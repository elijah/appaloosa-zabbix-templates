#!/usr/bin/perl
# Copyright 2010 (c) PalominoDB.
# Feedback and improvements are welcome.
#
# THIS PROGRAM IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
# MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, version 2.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc., 59 Temple
# Place, Suite 330, Boston, MA  02111-1307  USA.

use strict;
use warnings FATAL => 'all';
use Net::DNS;
use Time::HiRes qw(gettimeofday tv_interval usleep);
use constant DEBUG => $ENV{DEBUG} || 0;
use Data::Dumper;

# Path set to empty so that this script can be run SUID root.
$ENV{PATH} = "";

# The path to rndc. Redhat default shown below.
my $rndc = '/usr/sbin/rndc';

# The path to the stats file produced by named when 'rndc stats' is called.
# Redhat default shown below.
my $stats_file = '/var/named/chroot/var/named/data/named_stats.txt';

# The path to the zone/cache dump file produce by named when 'rndc dumpdb'
# is called. Redhat default shown below.
my $dump_file = '/var/named/chroot/var/named/data/cache_dump.db';

# Path to the named pidfile - used for determining named memory usage.
# Redhat default shown below.
my $pid_file = '/var/run/named.pid';

# By default, the ip for this nameserver is set to localhost.
# This is used for doing latency queries, and you may want to
# set it to an external ip to get more "representative" latencies.
my $ns_ip = '127.0.0.1';

# The default query to perform for latency timings.
# You probably want to change this to an actually configured zone.
my $ns_query = 'localhost.localdomain';

##############################################################################
# Below here, you shouldn't need to change anything.
##############################################################################

sub rndc {
  my $i = 4; # wait one full second for the stats file.
  my $stats = {};
  my $o;
  unlink($stats_file);
  my $r = qx/$rndc stats 2>&1/;
  chomp($r);
  if($r =~ /failed|error|found/i) {
    DEBUG && print(STDERR "$r\n");
    return {};
  }
  while($i && ! -f $stats_file) {
    $i--;
    usleep(250000);
    DEBUG && print(STDERR "waiting for $stats_file\n");
  }
  die("$stats_file never showed up. Is the script configured correctly?\n") if($i == 0);
  {
    local $/;
    open BIND_STATS, "<$stats_file" or die("while opening $stats_file: $!\n");
    $o = <BIND_STATS>;
    close BIND_STATS;
  }
  foreach (split "\n", $o) {
    chomp;
    next if(/_bind$/);
    next if(/^---/);
    next if(/^\+\+\+/);
    my ($stat, $val, $domain) = split;
    if(not defined($domain)) {
      $$stats{'global'}{$stat} = int($val);
    }
    else {
      $$stats{$domain}{$stat} = int($val);
    }
  }
  return $stats;
}

sub nrecords {
  my $count = 0;
  my $o;
  my $r = qx/$rndc dumpdb -zones 2>&1/;
  chomp($r);
  if($r =~ /failed|error|found/i) {
    DEBUG && print(STDERR "$r\n");
    return -1;
  }

  open my $bind_dump, "<$dump_file";
  while(<$bind_dump>) {
    chomp;
    # simply count up the number of lines in the file
    # one of the following record types: NS, A, MX, AAAA, PTR.
    # other record types are currently ignored.
    $count++ if(/IN\s+(?:NS|A|MX|AAAA|PTR)/);
  }
  close $bind_dump;
  return $count;
}

if( scalar(@ARGV) < 1 ) {
  print <<EOF;
Usage: bind9_stats.pl <stat> <zone>

Where stat is one of:

native per zone:
These statistics are measured by BIND and we
read them directly from the dump file produced
by 'rndc stats'
  - success
  - referral
  - nxrrset
  - nxdomain
  - recursion
  - failure

If <zone> is specified, then the stats reported will be
just for that zone, otherwise, they are global.

calculated:
These statistics are measured outside BIND, or by
doing a more complicated operation.

  - 'queries' sum of success,referral,nxrrset,nxdomain,recursion,failure.
  - 'latency' performs a query and measures response time.
  - 'pid'   returns the pid of the named process
  - 'VmPeak' peak memory usage of named.
  - 'VmSize' current memory usage
  - 'VmLck' locked in memory
  - 'VmHWM' high water mark
  - 'VmRSS' resident size
  - 'VmData' data size
  - 'VmStk' stack size
  - 'VmExe' exec size
  - 'VmLib' shared library
  - 'VmPTE' page table entries
  Of the above memory status, only VmSize and VmRSS are likely to be of
  interest. The others are included for completeness.

  - 'zones'  tracks how many zones are configured

  - 'records' number of A, NS, AAAA, MX, and PTR records configured.

NOTE: This script needs to be run as 'root', or the 'named' user
      since it needs to read and delete the rndc stats file.
      A simple way to achieve that is to make the script SUID named.

EOF
  exit(0);
}

my $pid = 0;
my $fh;
my $stats = rndc();
my $stat = shift @ARGV;
my $zone = shift @ARGV;
$zone ||= 'global';

# if no stats returned from RNDC, then clearly there's an error.
if( scalar( keys %$stats ) == 0 ) {
  print("-1\n");
  exit(1);
}

DEBUG && print(STDERR Dumper($stats), "\n");

if(not defined $$stats{$zone}) {
  print(STDERR "The stats file did not contain data for $zone.\n",
        "You may have made a typo, or there may be a misconfiguration ",
        "in named.conf.\n",
        "See http://code.google.com/p/appaloosa-zabbix-templates/wiki/Bind9Templates#Troubleshooting for help.\n");
  exit(1);
}

my $res = Net::DNS::Resolver->new( nameservers => [$ns_ip] );
my $t0 = [gettimeofday];
my $pckt = $res->query($ns_query);
$$stats{'global'}{'latency'} = tv_interval( $t0 );
$$stats{'global'}{'zones'} = scalar( keys %$stats );

# Special case the 'records' stat, because
# for very large zones, this could likely be expensive.
# so, it's only computed as necessary.
if( $stat eq 'records' ) {
  $$stats{'global'}{'records'} = nrecords();
}

DEBUG && print(STDERR "counting total queries for $zone..\n");
# compute the total queries for the 'queries' counter stat.
$$stats{$zone}{'queries'} = 0;
for(qw(success referral nxrrset nxdomain recursion failure)) {
  $$stats{$zone}{'queries'} += $$stats{$zone}{$_};
}

if( -f $pid_file ) {
  eval {
    {
      local $/;
      open $fh, "<$pid_file" or die("unable to open $pid_file: $!");
      $pid = <$fh>;
      close($fh);
    }
  };
  chomp($pid);
  $$stats{'global'}{'pid'} = $pid;
  open $fh, "/proc/$pid/status";
  while( <$fh> ) {
    next unless(/^(Vm|Threads).*/);
    my ($s, $v, $unit) = split(/\s+/, $_);
    $s =~ s/://;
    $$stats{'global'}{$s} = $v;
    if($unit and $unit eq 'kB') {
      $$stats{'global'}{$s} *= 1024;
    }
  }
  close($fh);
}

# print the statistic, or -1 on error.
print( (defined $$stats{$zone}{$stat}
          ? $$stats{$zone}{$stat}
            : -1), "\n");
exit(defined $$stats{$zone}{$stat} ? 0 : 1);
