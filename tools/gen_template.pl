#!/usr/bin/env perl
#
# This tool generates a zabbix XML template import from a meta-template.
#
# Copyright 2010 (c) Brian Smith <brian@palominodb.com> and PalominoDB.
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
#
use strict;
use warnings FATAL => 'all';
use XML::Simple;
use DateTime;
use Data::Dumper;
use Getopt::Long qw(:config no_ignore_case pass_through);
use Pod::Usage;

my %item_types = (
  Passive_agent => 0,
  Active_agent  => 7,
  Simple        => 3,
  SNMPv1        => 1,
  SNMPv2        => 4,
  SNMPv3        => 6,
  Trapper       => 2,
  Internal      => 5,
  Aggregate     => 8,
  WEB           => 9,
  DB            => 11,
  IPMI          => 12,
  SSH           => 13,
  Calculated    => 15
);

my %item_value_types = (
  Character => 1,
  Float     => 0,
  Integer   => 3,
  Log       => 2,
  Text      => 4
);

my %item_store_types = (
  As_is => 0,
  Delta_speed => 1,
  Delta_simple => 2
);

my %graph_display_types = (
  Normal => 0,
  Stacked => 1,
  Pie => 2,
  Exploded => 3,
);

my %graph_types = (
  Simple =>  0,
  Aggregated => 1
);

my %graph_item_funcs = (
  Avg => 2,
  Min => 1,
  Max => 4,
);

my %graph_yaxis_side = (
  Left => 0,
  Right => 1,
);

my %graph_item_draw = (
  Line => 0,
  Filled => 1,
  Bold => 2,
  Dot => 3,
  Dashed => 4,
  Gradient => 5,
);

my %trigger_severity = (
  Not_classified => 0,
  Information    => 1,
  Warning        => 2,
  Average        => 3,
  High           => 4,
  Disaster       => 5,
);

my %trigger_type = (
  Change => 0,
  Problem => 1,
);
my $help = 0;
my $tmpl = {};
my $xmlhash = {};

my $xs = new XML::Simple(KeepRoot => 1, KeyAttr => {  });

my $setting_interval = 3600;
my $perf_interval    = 120;

my $history = 60;
my $trends  = 365;

GetOptions(
  'help|h' => \$help,
  'setting-interval=i' => \$setting_interval,
  'perf-interval=i' => \$perf_interval,
  'history=i' => \$history,
  'trends=i' => \$trends,
);

pod2usage(0) if($help);

my $input = shift @ARGV;
my $output = shift @ARGV;

die('need an input template') unless($input);
die('need an output path') unless($output);

{
  local $/;
  open FH, "<$input" or die("$input: $!");
  my $d = <FH>;
  $tmpl = eval "$d";
  die("While parsing template: $@\n") if($@);
  close(FH);

  die('invalid template') unless($$tmpl{items} and $$tmpl{name} and $$tmpl{graphs});
}

$$tmpl{dependencies} ||= [];

$tmpl->{name} =~ s/\s+/_/g;

my $def_interval = $tmpl->{interval};
my $def_history  = $tmpl->{history};
my $def_trends   = $tmpl->{trends};
my $def_gwidth   = $tmpl->{graph_width};
my $def_gheight  = $tmpl->{graph_height};
my $def_graph_display_type = $tmpl->{graph_display_type};
my $def_graph_show_triggers = $tmpl->{graph_show_triggers};

my $def_value_type = $tmpl->{item_value};
my $def_item_type  = $tmpl->{item_type};

$xmlhash->{zabbix_export}->{version} = '1.0';
$xmlhash->{zabbix_export}->{date}    = '11.11.10';
$xmlhash->{zabbix_export}->{time}    = '04.09';

$xmlhash->{zabbix_export}->{hosts}->{host}            = [
   {
    name => $tmpl->{name},
    groups => { group => [
                          'Templates',
                          @{$$tmpl{groups}}
                         ]
              },
    triggers => {},
    items => { item => [
                        map {
                          my $out = $$tmpl{items}{$_};
                          die('Invalid storage type '. $$out{store}) if( not exists( $item_store_types{ $$out{store} } ) );
                          _d('item:', $_);
                          _d('item type:', or_default($$out{type}, $def_item_type));
                          {
                            type => $item_types{ or_default($$out{type}, $def_item_type) },
                            key=> $_,
                            value_type=> $item_value_types{ or_default($$out{value_type}, $def_value_type) },
                            description => { content => $$out{description} },
                            delay       => { content => or_default($$out{interval}, $def_interval) },
                            history     => { content => or_default($$out{history},  $def_history) },
                            trends      => { content => or_default($$out{trends},   $def_trends) },
                            data_type   => { content => 0 },
                            status      => { content => 0 },
                            units       => { content => $$out{units} },
                            delta       => { content => $item_store_types{ $$out{store} } },
                            applications => { application => $$tmpl{applications} },
                          };
                        } keys %{$$tmpl{items}}
                       ]
             },
    graphs => { graph => [
                           map {
                             my $graph = $_;
                             {
                               name => $graph->{name},
                               applications => { application => $$tmpl{applications} },
                               width => $def_gwidth,
                               height => $def_gheight,
                               ymin_type => { content => 0 },
                               ymax_type => { content => 0 },
                               ymin_item_key => { content => undef },
                               ymax_item_key => { content => undef },
                               show_work_period => { content => 1 },
                               graphtype => { content => $graph_display_types{ or_default($graph->{display_type}, $def_graph_display_type) } },
                               show_triggers => { content => or_default($graph->{show_triggers}, $def_graph_show_triggers) },
                               yaxismin => { content => '0.0000' },
                               yaxismax => { content => '100.0000' },
                               show_legend => { content => 1 },
                               show_3d => { content => 0 },
                               percent_left => { content => '0.0000' },
                               percent_right => { content => '0.0000' },
                               graph_elements => { graph_element => [
                                 map {
                                   _d(Dumper($_));
                                   my $item = $_;
                                   {
                                     item => "$$tmpl{name}:$$item{item}",
                                     color => { content => $$item{color} },
                                     yaxisside => { content => $graph_yaxis_side{or_default($$item{yaxisside}, 'Right')} },
                                     drawtype => { content => $graph_item_draw{ $$item{drawtype} } },
                                     type => { content => or_default($$item{type}, 0) },
                                     periods_cnt => { content => or_default($$item{periods}, 5) },
                                     calc_fnc => { content => $graph_item_funcs{ or_default($$item{func}, 'Avg') } },
                                   };
                                 } @{$$graph{items}}
                                ]
                                                 }
                             };
                           } @{$$tmpl{graphs}}
                          ]
              },
    triggers => { trigger => [
                              map {
                                my $item = $_;
                                if(exists $$item{depends_on}) {
                                  push @{$$tmpl{dependencies}}, { 'for' => "$$tmpl{name}:$$item{'description'}", 'on' => [ map { "$$tmpl{name}:$_" } @{$$item{depends_on}} ] };
                                }
                                $$item{expression} =~ s/\s+|\n//sg;
                                {
                                  status      => {content => 0 }, # always enable the triggers
                                  type        => {content => $trigger_type{ or_default($$item{event_on}, 'Change') } },
                                  description => {content => $$item{description} },
                                  expression  => {content => $$item{expression} },
                                  priority    => {content => $trigger_severity{ $$item{severity} } },
                                  applications => { application => $$tmpl{applications} },
                                };
                              } @{$$tmpl{triggers}}
                             ],
                },

   }
  ];
$xmlhash->{zabbix_export}->{dependencies} = {
  dependency => [
    map {
      my $dep = $_;
      {
        description => $dep->{'for'},
          depends => $dep->{'on'},
        };
    } @{$$tmpl{dependencies}}
  ],
};

open FH, ">$output" or die("$output:$!");
print(FH $xs->XMLout($xmlhash));


sub or_default {
  my ($value, $default) = @_;
  if(defined $value) {
    return $value;
  }
  return $default;
}

sub _d {
   my ($package, undef, $line) = caller 0;
   @_ = map { (my $temp = $_) =~ s/\n/\n# /g; $temp =~ s/^(\s+)$/'$1'/g; $temp; }
        map { defined $_ ? $_ : 'undef' }
        @_;
   print STDERR "# $package:$line ", join(' ', @_), "\n";
}

__END__

=head1 SYNOPSIS

Usage: gen_template.pl [options] TEMPLATE OUTPUT

Arguments:

TEMPLATE - Path to the meta-template. Usually found under "defs/".
OUTPUT   - Where to place the generated XML template.

Options:

  --help,-h  This help.

  --setting-interval     How often, in seconds, setting like items should be stored.
                         Items which do not change often use this value. 
                         Example: mysql.setting.pool_size.
                         Default: 3600.

  --perf-interval        How often, in seconds, performance counter items should be stored.
                         Items which change frequently use this.
                         Example: memcached[get_hits].
                         Default: 120.

  --history              How many days of history to keep. Default: 90.
  --trends               How many days of trends to keep. Default: 365.

Individual templates may also handle additional options.
For example, the BIND9 template handles the option --domain to allow you
to create templates for particular zones you host.
Refer to the top portion of a template to see what option it has,
or consult the wiki documentation for the template at:
http:://appaloosa-zabbix-templates.googlecode.com/
