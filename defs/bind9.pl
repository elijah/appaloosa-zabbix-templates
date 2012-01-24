# BIND9 template for Zabbix.
#
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
#

# Template options.
# Override defaults by adding options to the gen_template.pl commandline:
# Example: tools/gen_template.pl defs/bind9.pl bind9_example.com.xml --domain example.com
my $domain = 'global';
GetOptions('domain=s' => \$domain);

{
  name => "Template_BIND9_$domain",
  version => '0.0.2',
  interval => $perf_interval,
  history      => $history,
  trends       => $trends,
  item_value   => 'Float',
  item_type    => 'Passive_agent',
  applications => [ ($domain eq 'global' ? 'BIND9' : "BIND9 $domain") ],
  groups              => [],       # Implicitly added to the 'Templates' group
  graph_width         => 800,
  graph_height        => 150,
  graph_show_triggers => 1,
  graph_display_type  => 'Normal',

  graphs => [
    {
      items => [
        {
          color    => '57C9FF',
          item     => "bind9[success,$domain]",
          drawtype => 'Line',
        },
        {
          color    => '028CCC',
          item     => "bind9[recursion,$domain]",
          drawtype => 'Line',
        },
        {
          color    => '9461C6',
          item     => "bind9[referral,$domain]",
          drawtype => 'Line',
        },
        {
          color    => 'C15F8C',
          item     => "bind9[nxrrset,$domain]",
          drawtype => 'Line',
        },
        {
          color    => 'D91D1A',
          item     => "bind9[failure,$domain]",
          drawtype => 'Line',
                },
        {
          color    => 'BBFF00',
          item     => "bind9[nxdomain,$domain]",
          drawtype => 'Line',
        },
      ],
      name => "BIND9 $domain Queries",
    },
    {
      items => [
        {
          color    => '028CCC',
          item     => "bind9[queries,$domain]",
          drawtype => 'Filled',
        },
      ],
      name => "BIND9 $domain QPS",
    },
    ( $domain eq 'global' ? (
      {
        items => [
          {
            color    => '484443',
            item     => "bind9[latency]",
            drawtype => 'Line',
          },
          
        ],
        name => "BIND9 Query Latency",
      },
      
      {
        items => [
          {
            color    => '72E5FF',
            item     => "bind9[VmSize]",
            drawtype => 'Filled',
          },
          {
            color    => '6D6C73',
            item     => "bind9[VmRSS]",
          drawtype => 'Bold',
        },
          
        ],
        name => "BIND9 Memory Usage",
      },
    ) : () ),
  ],
  items => {
    "bind9[success,$domain]" => {
      description => "Successful queries",
      store       => "Delta_simple",
      interval    => $perf_interval,
    },
    "bind9[failure,$domain]" => {
      description => "Failed queries",
      store       => "Delta_simple",
      interval    => $perf_interval,
    },
    "bind9[recursion,$domain]" => {
      description => "Recursed queries",
      store       => "Delta_simple",
      interval    => $perf_interval,
    },
    "bind9[referral,$domain]" => {
      description => "Referred queries",
      store       => "Delta_simple",
      interval    => $perf_interval,
      },
    "bind9[nxrrset,$domain]" => {
      description => "NX Resouce queries",
      store       => "Delta_simple",
      interval    => $perf_interval,
    },
    "bind9[nxdomain,$domain]" => {
      description => "NX Domain queries",
      store       => "Delta_simple",
      interval    => $perf_interval,
      },
    "bind9[queries,$domain]" => {
      description => "Queries per second",
      store       => "Delta_speed",
      interval    => $perf_interval,
      },
    ( $domain eq 'global' ? (
      "bind9[latency]" => {
        description => "Query latency",
        store       => "As_is",
        interval    => $perf_interval,
      },
      "bind9[VmPeak]" => {
        description => "Peak VM memory usage",
        store       => "As_is",
        interval    => $perf_interval,
      },
      "bind9[VmSize]" => {
        description => "Current VM memory usage",
        store       => "As_is",
        interval    => $perf_interval,
      },
      "bind9[VmLck]" => {
        description => "Locked VM memory usage",
        store       => "As_is",
        interval    => $perf_interval,
      },
      "bind9[VmHWM]" => {
        description => "High Watermark VM memory usage",
        store       => "As_is",
        interval    => $perf_interval,
      },
      "bind9[VmRSS]" => {
        description => "Resident VM memory usage",
        store       => "As_is",
        interval    => $perf_interval,
      },
      "bind9[VmData]" => {
        description => "Data VM memory usage",
        store       => "As_is",
        interval    => $perf_interval,
      },
      "bind9[VmStk]" => {
        description => "Stack VM memory usage",
        store       => "As_is",
        interval    => $perf_interval,
      },
      "bind9[VmExe]" => {
        description => "Exec VM memory usage",
        store       => "As_is",
        interval    => $perf_interval,
      },
      "bind9[VmLib]" => {
        description => "Shared library VM memory usage",
        store       => "As_is",
        interval    => $perf_interval,
      },
      "bind9[VmPTE]" => {
        description => "Page table entry VM memory usage",
        store       => "As_is",
        interval    => $perf_interval,
      },
      "bind9[zones]" => {
        description => 'Zones being served',
        store       => 'As_is',
        interval    => $setting_interval
      },
      "bind9[records]" => {
        description => 'Total zone records being served',
        store       => 'As_is',
        interval    => $setting_interval
      },
      "proc.num[named]" => {
        description => 'Named processes',
        store       => 'As_is',
        interval    => $perf_interval,
      },
      "bind9[pid]" => {
        description => 'Named PID',
        store       => 'As_is',
        interval    => $setting_interval
      }
    ) : () ),
  },

  triggers => [
    ( $domain eq 'global' ? (
      {
        description => 'Named process not running on {HOSTNAME}',
        expression  => "{Template_BIND9_$domain:proc.num[named].last(0)}=0",
        severity    => 'High'
        },
      {
        description => 'Named high query latency on {HOSTNAME}',
        expression  => "{Template_BIND9_$domain:bind9[latency].last(0)}>5.0",
        severity    => 'High',
        depends_on  => ['Named process not running on {HOSTNAME}']
      },
    ) : () )
  ],
};
