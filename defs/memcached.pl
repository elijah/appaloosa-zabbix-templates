# Memcached/Membase template for Zabbix.
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
# Example: tools/gen_template.pl defs/memcached.pl memcached_9000.xml --memcached-port 9000
my $port = 11211;
GetOptions('memcached-port=i' => \$port);

{
  name => "Template_Memcached_$port",
  version => '0.0.2',
  interval => $perf_interval,
  history      => $history,
  trends       => $trends,
  item_value   => 'Float',
  item_type    => 'Passive_agent',
  applications => [ 'Memcached' ],
  groups              => [],       # Implicitly added to the 'Templates' group
  graph_width         => 800,
  graph_height        => 150,
  graph_show_triggers => 1,
  graph_display_type  => 'Normal',

  graphs => [
        {
            items => [
                {
                    color    => '157419',
                    item     => "memcached[total_items,$port]",
                    drawtype => 'Filled',
                },
                {
                    color    => 'AFECED',
                    item     => "memcached[evictions,$port]",
                    drawtype => 'Line',
                },
            ],
            name => 'Memcached Items/Evictions',
        },

        {
           items => [
                {
                    color    => 'EDAA41',
                    item     => "memcached[curr_connections,$port]",
                    drawtype => 'Filled',
                },
           ],
           name => 'Memcached Connections'
        },

        {
           items => [
                {
                    color    => 'AFECED',
                    item     => "memcached[curr_items,$port]",
                    drawtype => 'Line',
                },
           ],
           name => 'Memcached Current Items'
        },

        {
           items => [
                {
                    color    => 'EDAA41',
                    item     => "memcached[total_connections,$port]",
                    drawtype => 'Line',
                },
           ],
           name => 'Memcached Connection Rate'
        },

        {
           items => [
                {
                    color    => 'AFECED',
                    item     => "memcached[bytes,$port]",
                    drawtype => 'Gradient',
                },
                {
                    color    => '7020AF',
                    item     => "memcached[limit_maxbytes,$port]",
                    drawtype => 'Gradient',
                },
           ],
           name => 'Memcached Memory Usage'
        },

        {
           items => [
                {
                    color    => 'AFECED',
                    item     => "memcached[cmd_get,$port]",
                    drawtype => 'Filled',
                },
                {
                    color    => 'F51D30',
                    item     => "memcached[cmd_set,$port]",
                    drawtype => 'Gradient',
                },
                {
                    color    => '862F2F',
                    item     => "memcached[cmd_flush,$port]",
                    drawtype => 'Gradient',
                },
           ],
           name => 'Memcached Commands'
        },

        {
           items => [
                {
                    color    => 'AFECED',
                    item     => "memcached[get_misses,$port]",
                    drawtype => 'Filled',
                },
                {
                    color    => 'F51D30',
                    item     => "memcached[get_hits,$port]",
                    drawtype => 'Gradient',
                },
           ],
           name => 'Memcached Get Hits/Misses'
        },

        {
           items => [
                {
                    color    => 'AFECED',
                    item     => "memcached[delete_misses,$port]",
                    drawtype => 'Filled',
                },
                {
                    color    => 'F51D30',
                    item     => "memcached[delete_hits,$port]",
                    drawtype => 'Gradient',
                },
           ],
           name => 'Memcached Delete Hits/Misses'
        },

        {
           items => [
                {
                    color    => 'AFECED',
                    item     => "memcached[decr_misses,$port]",
                    drawtype => 'Filled',
                },
                {
                    color    => 'F51D30',
                    item     => "memcached[decr_hits,$port]",
                    drawtype => 'Gradient',
                },

                {
                    color    => 'E84A5F',
                    item     => "memcached[incr_misses,$port]",
                    drawtype => 'Filled',
                },
                {
                    color    => 'D1642E',
                    item     => "memcached[incr_hits,$port]",
                    drawtype => 'Gradient',
                },
           ],
           name => 'Memcached Decr/Incr Hits/Misses'
        },

        {
           items => [
                {
                    color    => 'AFECED',
                    item     => "memcached[cas_misses,$port]",
                    drawtype => 'Filled',
                },
                {
                    color    => 'F51D30',
                    item     => "memcached[cas_hits,$port]",
                    drawtype => 'Gradient',
                },
           ],
           name => 'Memcached CAS Hits/Misses'
        },

        {
           items => [
                {
                    color    => '862F2F',
                    item     => "memcached[threads,$port]",
                    drawtype => 'Gradient',
                },
           ],
           name => 'Memcached Threads'
        },

        {
           items => [
                {
                    color    => '862F2F',
                    item     => "memcached[rusage_user,$port]",
                    drawtype => 'Line',
                },
                {
                    color    => '0000FF',
                    item     => "memcached[rusage_system,$port]",
                    drawtype => 'Line',
                },
           ],
           name => 'Memcached CPU Time'
        },

        {
           items => [
                {
                    color    => '00CF00',
                    item     => "memcached[bytes_read,$port]",
                    drawtype => 'Filled',
                },
                {
                    color    => '002A97',
                    item     => "memcached[bytes_written,$port]",
                    drawtype => 'Bold',
                },
           ],
           name => 'Memcached Network Traffic'
        },

        {
           items => [
                {
                    color    => '862F2F',
                    item     => "memcached[reclaimed,$port]",
                    drawtype => 'Bold',
                },
           ],
           name => 'Memcached Reclaimed'
        },
  ],

  items => {
    "memcached[pid,$port]" => {
      description => 'Memcached PID',
      store       => 'As_is',
      interval    => $setting_interval
    },
    "memcached[uptime,$port]" => {
      description => 'Memcached uptime',
      store       => 'As_is',
      interval    => $perf_interval,
    },
    "memcached[version,$port]" => {
      description => 'Memcached version',
      store       => 'As_is',
      interval    => $setting_interval,
    },
    "memcached[pointer_size,$port]" => {
      description => 'Memcached pointer_size',
      store       => 'As_is',
      interval    => $setting_interval,
    },
    "memcached[rusage_user,$port]" => {
      description => 'Memcached rusage_user',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[rusage_system,$port]" => {
      description => 'Memcached rusage_system',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[curr_connections,$port]" => {
      description => 'Memcached curr_connections',
      store       => 'As_is',
      interval    => $perf_interval,
    },
    "memcached[total_connections,$port]" => {
      description => 'Memcached total_connections',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[connection_structures,$port]" => {
      description => 'Memcached connection_structures',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[cmd_get,$port]" => {
      description => 'Memcached cmd_get',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[cmd_set,$port]" => {
      description => 'Memcached cmd_set',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[cmd_flush,$port]" => {
      description => 'Memcached cmd_flush',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[get_hits,$port]" => {
      description => 'Memcached get_hits',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[get_misses,$port]" => {
      description => 'Memcached get_misses',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[delete_misses,$port]" => {
      description => 'Memcached delete_misses',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[delete_hits,$port]" => {
      description => 'Memcached delete_hits',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[incr_misses,$port]" => {
      description => 'Memcached incr_misses',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[incr_hits,$port]" => {
      description => 'Memcached incr_hits',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[decr_misses,$port]" => {
      description => 'Memcached decr_misses',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[decr_hits,$port]" => {
      description => 'Memcached decr_hits',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[cas_misses,$port]" => {
      description => 'Memcached cas_misses',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[cas_hits,$port]" => {
      description => 'Memcached cas_hits',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[cas_badval,$port]" => {
      description => 'Memcached cas_badval',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[auth_cmds,$port]" => {
      description => 'Memcached auth_cmds',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[auth_errors,$port]" => {
      description => 'Memcached auth_errors',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[bytes_read,$port]" => {
      description => 'Memcached bytes_read',
      store       => 'Delta_simple',
      units       => 'B',
      interval    => $perf_interval,
    },
    "memcached[bytes_written,$port]" => {
      description => 'Memcached bytes_written',
      store       => 'Delta_simple',
      units       => 'B',
      interval    => $perf_interval,
    },
    "memcached[limit_maxbytes,$port]" => {
      description => 'Memcached limit_maxbytes',
      store       => 'As_is',
      unit        => 'B',
      interval    => $setting_interval,
    },
    "memcached[accepting_conns,$port]" => {
      description => 'Memcached accepting_conns',
      store       => 'As_is',
      interval    => $perf_interval,
    },
    "memcached[listen_disabled_num,$port]" => {
      description => 'Memcached listen_disabled_num',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[threads,$port]" => {
      description => 'Memcached threads',
      store       => 'As_is',
      interval    => $perf_interval,
    },
    "memcached[conn_yields,$port]" => {
      description => 'Memcached conn_yields',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[bytes,$port]" => {
      description => 'Memcached bytes',
      store       => 'As_is',
      units       => 'B',
      interval    => $perf_interval,
    },
    "memcached[curr_items,$port]" => {
      description => 'Memcached curr_items',
      store       => 'As_is',
      interval    => $perf_interval,
    },
    "memcached[total_items,$port]" => {
      description => 'Memcached total_items',
      store       => 'As_is',
      interval    => $perf_interval,
    },
    "memcached[evictions,$port]" => {
      description => 'Memcached evictions',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "memcached[reclaimed,$port]" => {
      description => 'Memcached reclaimed',
      store       => 'Delta_simple',
      interval    => $perf_interval,
    },
    "proc.num[memcached]" => {
      description => "Memcached Processes",
      store       => 'As_is',
      interval    => $perf_interval
    },
    "net.tcp.port[127.0.0.1,$port]" => {
      description => "Memcached port status",
      store       => 'As_is',
      interval    => $perf_interval
    },
    "system.cpu.num" => {
      description => "Memcached Num CPUs",
      store       => 'As_is',
      interval    => $setting_interval
    }
  },

  triggers => [
    {
      description => 'Memcached port not responding on {HOSTNAME}',
      expression  => "{Template_Memcached_$port:net.tcp.port[127.0.0.1,$port].last(0)}=0",
      severity    => 'Average',
      depends_on  => [ 'Memcached process not running on {HOSTNAME}' ],
    },
    {
      description => 'Memcached process not running on {HOSTNAME}',
      expression  => "{Template_Memcached_$port:proc.num[memcached].last(0)}=0",
      severity    => 'Average'
    },
    {
      description => 'Memcached CPU user time over 90% on {HOSTNAME}',
      expression  => "{Template_Memcached_$port:memcached[rusage_user,$port].change(0)/Template_Memcached_$port:system.cpu.num.last(0)}>90",
      severity    => 'Warning',
      depends_on  => [ 'Memcached process not running on {HOSTNAME}' ],
    },
  ],
};
