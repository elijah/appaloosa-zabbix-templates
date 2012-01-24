# MySQL template for zabbix.
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

{

    # these specify top-level defaults
    # for items and graphs
    name         => 'Template_MySQL',
    version      => '0.0.5',
    interval     => $perf_interval,
    history      => $history,
    trends       => $trends,
    item_value   => 'Float',
    item_type    => 'Passive_agent',
    applications => [ 'MySQL' ],
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
                    item     => 'mysql.Key_read_requests',
                    drawtype => 'Filled',
                },
                {
                    color    => 'AFECED',
                    item     => 'mysql.Key_reads',
                    drawtype => 'Line',
                },
                {
                    color    => '862F2F',
                    item     => 'mysql.Key_write_requests',
                    drawtype => 'Filled',
                    cdef     => 'Negate',
                },
                {
                    color    => 'F51D30',
                    item     => 'mysql.Key_writes',
                    drawtype => 'Line',
                    cdef     => 'Negate',
                },
            ],
            name => 'MyISAM Indexes',
        },
        {
            name  => 'MyISAM Key Cache',
            items => [
                {
                    item  => 'mysql.setting.key_buffer_size',
                    color => '99B898',
                    drawtype  => 'Filled',
                },
                {
                    item  => 'mysql.Key_buf_bytes_used',
                    color => '2A363B',
                    drawtype  => 'Filled',
                },
                {
                    item  => 'mysql.Key_buf_bytes_unflushed',
                    color => 'FECEA8',
                    drawtype  => 'Filled',
                },
            ],
        },
        {
            name  => 'InnoDB Buffer Pool',
            items => [
                {
                    color => '3D1500',
                    item  => 'mysql.setting.pool_size',
                    drawtype  => 'Filled',
                },
                {
                    color => 'EDAA41',
                    item  => 'mysql.database_pages',
                    drawtype  => 'Filled',
                },
                {
                    color => 'AA3B27',
                    item  => 'mysql.free_pages',
                    drawtype  => 'Gradient',
                },
                {
                    color => '13343B',
                    item  => 'mysql.modified_pages',
                    drawtype  => 'Line',
                },
            ],
        },
        {

           # Palette: http://www.colourlovers.com/palette/299787/What_Shall_I_Do
            name  => 'InnoDB I/O',
            items => [
                {
                    color => '402204',
                    item  => 'mysql.file_reads',
                    drawtype  => 'Line',
                },
                {
                    color => 'B3092B',
                    item  => 'mysql.file_writes',
                    drawtype  => 'Line',
                },
                {
                    color => 'FFBF00',
                    item  => 'mysql.log_writes',
                    drawtype  => 'Line',
                },
                {
                    color => '0ABFCC',
                    item  => 'mysql.file_fsyncs',
                    drawtype  => 'Line',
                },
            ],
        },
        {
            name  => 'InnoDB Insert Buffer',
            items => [
                {
                    color => '157419',
                    item  => 'mysql.ibuf_inserts',
                    drawtype  => 'Line',
                },
                {
                    color => '0000FF',
                    item  => 'mysql.ibuf_merged',
                    drawtype  => 'Line',
                },
                {
                    color => '862F2F',
                    item  => 'mysql.ibuf_merges',
                    drawtype  => 'Line',
                },
            ],
        },
        {
            name  => 'InnoDB Insert Buffer Usage',
            items => [
                {
                    color => '793A57',
                    item  => 'mysql.ibuf_cell_count',
                    drawtype  => 'Filled',
                },
                {
                    color => '8C873E',
                    item  => 'mysql.ibuf_used_cells',
                    drawtype  => 'Filled',
                },
                {
                    color => 'A38A5F',
                    item  => 'mysql.ibuf_free_cells',
                    drawtype  => 'Gradient',
                },
            ],
        },
        {
            items => [
                {
                    color => '306078',
                    item  => 'mysql.spin_rounds',
                    drawtype  => 'Line',
                },
                {
                    color => '4444FF',
                    item  => 'mysql.spin_waits',
                    drawtype  => 'Line',
                },
                {
                    color => '157419',
                    item  => 'mysql.os_waits',
                    drawtype  => 'Line',
                },
            ],
            name => 'InnoDB Semaphores',
        },
        {
            items => [
                {
                    color => 'AFECED',
                    item  => 'mysql.rows_read',
                    drawtype  => 'Filled',
                },
                {
                    color => 'DA4725',
                    item  => 'mysql.rows_deleted',
                    drawtype  => 'Gradient',
                },
                {
                    color => 'EA8F00',
                    item  => 'mysql.rows_updated',
                    drawtype  => 'Gradient',
                },
                {
                    color => '35962B',
                    item  => 'mysql.rows_inserted',
                    drawtype  => 'Gradient',
                },
            ],
            name => 'InnoDB Row Operations',
        },
        {
            items => [
                {
                    color => 'D2D8F9',
                    item  => 'mysql.Table_locks_immediate',
                    drawtype  => 'Filled',
                },
                {
                    color => '002A8F',
                    item  => 'mysql.Table_locks_immediate',
                    drawtype  => 'Line',
                },
                {
                    color => 'FF3932',
                    item  => 'mysql.Table_locks_waited',
                    drawtype  => 'Filled',
                },
                {
                    color => '35962B',
                    item  => 'mysql.Slow_queries',
                    drawtype  => 'Line',
                },
            ],
            name => 'MySQL Table Locks',
        },
        {
            items => [
                {
                    color => 'C0C0C0',
                    item  => 'mysql.setting.max_connections',
                    drawtype  => 'Filled',
                },
                {
                    color => 'FFD660',
                    item  => 'mysql.Max_used_connections',
                    drawtype  => 'Filled',
                },
                {
                    color => 'FF3932',
                    item  => 'mysql.Aborted_clients',
                    drawtype  => 'Line',
                },
                {
                    color => '00FF00',
                    item  => 'mysql.Aborted_connects',
                    drawtype  => 'Line',
                },
                {
                    color => 'FF7D00',
                    item  => 'mysql.Threads_connected',
                    drawtype  => 'Bold',
                },
                {
                    color => '4444FF',
                    item  => 'mysql.Connections',
                    drawtype  => 'Line',
                },
            ],
            name => 'MySQL Connections',
        },
        {
            items => [
                {
                    color => '96E78A',
                    item  => 'mysql.slave_running',
                    drawtype  => 'Filled',
                },
                {
                    color => 'CDCFC4',
                    item  => 'mysql.slave_stopped',
                    drawtype  => 'Filled',
                },
                {
                    color => '4444FF',
                    item  => 'mysql.slave_lag',
                    drawtype  => 'Line',
                },
                {
                    color => '8D00BA',
                    item  => 'mysql.Slave_open_temp_tables',
                    drawtype  => 'Line',
                },
                {
                    color => 'FF0000',
                    item  => 'mysql.Slave_retried_transactions',
                    drawtype  => 'Line',
                },
            ],
            name => 'MySQL Replication',
        },
        {
            name  => 'MySQL Query Cache',
            items => [
                {
                    color => '4444FF',
                    item  => 'mysql.Qcache_queries_in_cache',
                    drawtype  => 'Bold',
                },
                {
                    color => 'EAAF00',
                    item  => 'mysql.Qcache_hits',
                    drawtype  => 'Bold',
                },
                {
                    color => '157419',
                    item  => 'mysql.Qcache_inserts',
                    drawtype  => 'Line',
                },
                {
                    color => '00A0C1',
                    item  => 'mysql.Qcache_not_cached',
                    drawtype  => 'Line',
                },
                {
                    color => 'FF0000',
                    item  => 'mysql.Qcache_lowmem_prunes',
                    drawtype  => 'Line',
                },
            ],
        },
        {
            name  => 'MySQL Query Cache Memory',
            items => [
                {
                    color => '74C366',
                    item  => 'mysql.setting.query_cache_size',
                    drawtype  => 'Filled',
                },
                {
                    color => 'FFC3C0',
                    item  => 'mysql.Qcache_free_memory',
                    drawtype  => 'Filled',
                },
                {
                    color => '8D00BA',
                    item  => 'mysql.Qcache_total_blocks',
                    drawtype  => 'Line',
                },
                {
                    color => '837C04',
                    item  => 'mysql.Qcache_free_blocks',
                    drawtype  => 'Line',
                },
            ],
        },
        {
            items => [
                {
                    color => 'FFC3C0',
                    item  => 'mysql.Questions',
                    drawtype  => 'Filled',
                },
                {
                    color => 'FF0000',
                    item  => 'mysql.Com_select',
                    drawtype  => 'Filled',
                },
                {
                    color => 'FF7D00',
                    item  => 'mysql.Com_delete',
                    drawtype  => 'Gradient',
                },
                {
                    color => 'FFF200',
                    item  => 'mysql.Com_insert',
                    drawtype  => 'Gradient',
                },
                {
                    color => '00CF00',
                    item  => 'mysql.Com_update',
                    drawtype  => 'Gradient',
                },
                {
                    color => '2175D9',
                    item  => 'mysql.Com_replace',
                    drawtype  => 'Gradient',
                },
                {
                    color => '55009D',
                    item  => 'mysql.Com_load',
                    drawtype  => 'Gradient',
                },
                {
                    color => '942D0C',
                    item  => 'mysql.Com_delete_multi',
                    drawtype  => 'Gradient',
                },
                {
                    color => 'AAABA1',
                    item  => 'mysql.Com_insert_select',
                    drawtype  => 'Gradient',
                },
                {
                    color => 'D8ACE0',
                    item  => 'mysql.Com_update_multi',
                    drawtype  => 'Gradient',
                },
                {
                    color => '00B99B',
                    item  => 'mysql.Com_replace_select',
                    drawtype  => 'Gradient',
                },
            ],
            name => 'MySQL Command Counters',
        },
        {
            name  => 'MySQL Select Types',
            items => [
                {
                    color => '3D1500',
                    item  => 'mysql.Select_full_join',
                    drawtype  => 'Filled',
                },
                {
                    color => 'AA3B27',
                    item  => 'mysql.Select_full_range_join',
                    drawtype  => 'Gradient',
                },
                {
                    color => 'EDAA41',
                    item  => 'mysql.Select_range',
                    drawtype  => 'Gradient',
                },
                {
                    color => '13343B',
                    item  => 'mysql.Select_range_check',
                    drawtype  => 'Gradient',
                },
                {
                    color => '686240',
                    item  => 'mysql.Select_scan',
                    drawtype  => 'Gradient',
                },
            ],
        },
        {
            items => [
                {
                    color => 'FFAB00',
                    item  => 'mysql.Sort_rows',
                    drawtype  => 'Filled',
                },
                {
                    color => '157419',
                    item  => 'mysql.Sort_range',
                    drawtype  => 'Line',
                },
                {
                    color => 'DA4725',
                    item  => 'mysql.Sort_merge_passes',
                    drawtype  => 'Line',
                },
                {
                    color => '4444FF',
                    item  => 'mysql.Sort_scan',
                    drawtype  => 'Line',
                },
            ],
            name => 'MySQL Sorts',
        },
        {
            items => [
                {
                    color => 'FFAB00',
                    item  => 'mysql.Created_tmp_tables',
                    drawtype  => 'Filled',
                },
                {
                    color => '837C04',
                    item  => 'mysql.Created_tmp_tables',
                    drawtype  => 'Line',
                },
                {
                    color => 'F51D30',
                    item  => 'mysql.Created_tmp_disk_tables',
                    drawtype  => 'Line',
                },
                {
                    color => '157419',
                    item  => 'mysql.Created_tmp_files',
                    drawtype  => 'Bold',
                },
            ],
            name => 'MySQL Temporary Objects',
        },
        {
            name => 'MySQL Network Traffic',
            items => [
                {
                    color => '4B2744',
                    item  => 'mysql.Bytes_sent',
                    drawtype  => 'Filled',
                },
                {
                    color => 'E4C576',
                    item  => 'mysql.Bytes_received',
                    drawtype  => 'Filled',
                    cdef  => 'Negate',
                },
            ],
        },
        {
            name  => 'InnoDB Buffer Pool Activity',
            items => [
                {
                    color => 'D6883A',
                    item  => 'mysql.pages_created',
                    drawtype  => 'Filled',
                },
                {
                    color => 'E6D883',
                    item  => 'mysql.pages_read',
                    drawtype  => 'Gradient',
                },
                {
                    color => '55AD84',
                    item  => 'mysql.pages_written',
                    drawtype  => 'Filled',
                },
            ],
        },
        {
            items => [
                {
                    color => 'FF0000',
                    item  => 'mysql.pending_aio_log_ios',
                    drawtype  => 'Line',
                },
                {
                    color => 'FF7D00',
                    item  => 'mysql.pending_aio_sync_ios',
                    drawtype  => 'Line',
                },
                {
                    color => 'FFF200',
                    item  => 'mysql.pending_buf_pool_flushes',
                    drawtype  => 'Line',
                },
                {
                    color => '00A348',
                    item  => 'mysql.pending_chkp_writes',
                    drawtype  => 'Line',
                },
                {
                    color => '6DC8FE',
                    item  => 'mysql.pending_ibuf_aio_reads',
                    drawtype  => 'Line',
                },
                {
                    color => '4444FF',
                    item  => 'mysql.pending_log_flushes',
                    drawtype  => 'Line',
                },
                {
                    color => '55009D',
                    item  => 'mysql.pending_log_writes',
                    drawtype  => 'Line',
                },
                {
                    color => 'B90054',
                    item  => 'mysql.pending_normal_aio_reads',
                    drawtype  => 'Line',
                },
                {
                    color => '8F9286',
                    item  => 'mysql.pending_normal_aio_writes',
                    drawtype  => 'Line',
                },
            ],
            name => 'InnoDB I/O Pending',
        },
        {
            name  => 'InnoDB Log',
            items => [
                {
                    color => '6E3803',
                    item  => 'mysql.innodb_log_buffer_size',
                    drawtype  => 'Filled',
                },
                {
                    color => '5B8257',
                    item  => 'mysql.log_bytes_written',
                    drawtype  => 'Filled',
                },
                {
                    color => 'AB4253',
                    item  => 'mysql.log_bytes_flushed',
                    drawtype  => 'Line',
                },
                {
                    color => 'AFECED',
                    item  => 'mysql.unflushed_log',
                    drawtype  => 'Filled',
                },
            ],
        },
        {
            items => [
                {
                    color => '35962B',
                    item  => 'mysql.Binlog_cache_use',
                    drawtype  => 'Line',
                },
                {
                    color => 'FF0000',
                    item  => 'mysql.Binlog_cache_disk_use',
                    drawtype  => 'Line',
                },
                {
                    color => '8D00BA',
                    item  => 'mysql.binary_log_space',
                    drawtype  => 'Line',
                },
                {
                    color => '8F005C',
                    item  => 'mysql.relay_log_space',
                    drawtype  => 'Line',
                },
            ],
            name => 'MySQL Binary/Relay Logs',
        },
        {
            name => 'InnoDB Transactions',

            items => [
                {
                    color => '8F005C',
                    item  => 'mysql.innodb_transactions',
                    drawtype  => 'Line',
                },
                {
                    color => '4444FF',
                    item  => 'mysql.current_transactions',
                    drawtype  => 'Line',
                },
                {
                    color => 'FF7D00',
                    item  => 'mysql.history_list',
                    drawtype  => 'Line',
                },
                {
                    color => '74C366',
                    item  => 'mysql.read_views',
                    drawtype  => 'Line',
                },
            ],
        },
        {
            name  => 'InnoDB Active/Locked Transactions',
            items => [
                {
                    color => 'C0C0C0',
                    item  => 'mysql.active_transactions',
                    drawtype  => 'Filled',
                },
                {
                    color => 'FF0000',
                    item  => 'mysql.locked_transactions',
                    drawtype  => 'Line',
                },
            ],
        },
        {
            name => 'MySQL Files and Tables',

            items => [
                {
                    color => 'D09887',
                    item  => 'mysql.setting.table_cache',
                    drawtype  => 'Filled',
                },
                {
                    color => '4A6959',
                    item  => 'mysql.Open_tables',
                    drawtype  => 'Line',
                },
                {
                    color => '1D1159',
                    item  => 'mysql.Open_files',
                    drawtype  => 'Line',
                },
                {
                    color => 'DE0056',
                    item  => 'mysql.Opened_tables',
                    drawtype  => 'Line',
                },
            ],
        },
        {
            items => [
                {
                    color => 'D8ACE0',
                    item  => 'mysql.setting.thread_cache_size',
                    drawtype  => 'Filled',
                },
                {
                    color => 'DE0056',
                    item  => 'mysql.Threads_created',
                    drawtype  => 'Bold',
                },
            ],
            name => 'MySQL Threads',
        },
        {
            name  => 'InnoDB Memory Allocation',
            items => [
                {
                    color => '53777A',
                    item  => 'mysql.total_mem_alloc',
                    drawtype  => 'Filled',
                },
                {
                    color => 'C02942',
                    item  => 'mysql.additional_pool_alloc',
                    drawtype  => 'Line',
                },
            ],
        },
        {
            name  => 'InnoDB Adaptive Hash Index',
            items => [
                {
                    color => '0C4E5D',
                    item  => 'mysql.hash_index_cells_total',
                    drawtype  => 'Filled',
                },
                {
                    color => 'D9C7A3',
                    item  => 'mysql.hash_index_cells_used',
                    drawtype  => 'Filled',
                },
            ],
        },
        {
            name  => 'InnoDB Internal Hash Memory Usage',
            items => [
                {
                    color => '793A57',
                    item  => 'mysql.adaptive_hash_memory',
                    drawtype  => 'Filled',
                },
                {
                    color => '8C873E',
                    item  => 'mysql.page_hash_memory',
                    drawtype  => 'Gradient',
                },
                {
                    color => 'D1C5A5',
                    item  => 'mysql.dictionary_cache_memory',
                    drawtype  => 'Gradient',
                },
                {
                    color => '4D3339',
                    item  => 'mysql.file_system_memory',
                    drawtype  => 'Gradient',
                },
                {
                    color => 'A38A5F',
                    item  => 'mysql.lock_system_memory',
                    drawtype  => 'Gradient',
                },
                {
                    color => 'E97F02',
                    item  => 'mysql.recovery_system_memory',
                    drawtype  => 'Gradient',
                },
                {
                    color => '23B0BA',
                    item  => 'mysql.thread_hash_memory',
                    drawtype  => 'Gradient',
                },
            ],
        },
        {
            name  => 'InnoDB Tables In Use',
            items => [
                {
                    color => 'D99362',
                    item  => 'mysql.innodb_tables_in_use',
                    drawtype  => 'Filled',
                },
                {
                    color => '663344',
                    item  => 'mysql.innodb_locked_tables',
                    drawtype  => 'Line',
                },
            ],
        },
        {
            name  => 'InnoDB Current Lock Waits',
            items => [
                {
                    color => '201A33',
                    item  => 'mysql.innodb_lock_wait_secs',
                    drawtype  => 'Line',
                },
            ],
        },
        {
            name  => 'InnoDB Lock Structures',
            items => [
                {
                    color => '0C4E5D',
                    item  => 'mysql.innodb_lock_structs',
                    drawtype  => 'Line',
                },
            ],
        },
        {
            name  => 'InnoDB Checkpoint Age',
            items => [
                {
                    color => '661100',
                    item  => 'mysql.uncheckpointed_bytes',
                    drawtype  => 'Line',
                },
            ],
        },
        {
            name  => 'InnoDB Row Lock Time',
            items => [
                {
                    item  => 'mysql.Innodb_row_lock_time',
                    color => 'B11D03',
                    drawtype  => 'Filled',
                },
            ],
        },
        {
            name  => 'InnoDB Row Lock Waits',
            items => [
                {
                    item  => 'mysql.Innodb_row_lock_waits',
                    color => 'E84A5F',
                    drawtype  => 'Filled',
                },
            ],
        },
        {
            name       => 'InnoDB Semaphore Waits',
            items      => [
                {
                    color => '7020AF',
                    item  => 'mysql.innodb_sem_waits',
                    drawtype  => 'Filled',
                },
            ],
        },
        {
            name  => 'InnoDB Semaphore Wait Time',
            items => [
                {
                    color => '708226',
                    item  => 'mysql.innodb_sem_wait_time_ms',
                    drawtype  => 'Filled',
                },
            ],
        },
        {
            name  => 'MySQL Processlist',
            items => [
                {
                    color => 'DE0056',
                    item  => 'mysql.State_closing_tables',
                    drawtype  => 'Filled',
                },
                {
                    color => '784890',
                    item  => 'mysql.State_copying_to_tmp_table',
                    drawtype  => 'Gradient',
                },
                {
                    color => 'D1642E',
                    item  => 'mysql.State_end',
                    drawtype  => 'Gradient',
                },
                {
                    color => '487860',
                    item  => 'mysql.State_freeing_items',
                    drawtype  => 'Gradient',
                },
                {
                    color => '907890',
                    item  => 'mysql.State_init',
                    drawtype  => 'Gradient',
                },
                {
                    color => 'DE0056',
                    item  => 'mysql.State_locked',
                    drawtype  => 'Gradient',
                },
                {
                    color => '1693A7',
                    item  => 'mysql.State_login',
                    drawtype  => 'Gradient',
                },
                {
                    color => '783030',
                    item  => 'mysql.State_preparing',
                    drawtype  => 'Gradient',
                },
                {
                    color => 'FF7F00',
                    item  => 'mysql.State_reading_from_net',
                    drawtype  => 'Gradient',
                },
                {
                    color => '54382A',
                    item  => 'mysql.State_sending_data',
                    drawtype  => 'Gradient',
                },
                {
                    color => 'B83A04',
                    item  => 'mysql.State_sorting_result',
                    drawtype  => 'Gradient',
                },
                {
                    color => '6E3803',
                    item  => 'mysql.State_statistics',
                    drawtype  => 'Gradient',
                },
                {
                    color => 'B56414',
                    item  => 'mysql.State_updating',
                    drawtype  => 'Gradient',
                },
                {
                    color => '6E645A',
                    item  => 'mysql.State_writing_to_net',
                    drawtype  => 'Gradient',
                },
                {
                    color => '521808',
                    item  => 'mysql.State_none',
                    drawtype  => 'Gradient',
                },
                {
                    color => '194240',
                    item  => 'mysql.State_other',
                    drawtype  => 'Gradient',
                },
            ],
        },
        {
            name  => 'MySQL Transaction Handler',
            items => [
                {
                    color => 'DE0056',
                    item  => 'mysql.Handler_commit',
                    drawtype  => 'Line',
                },
                {
                    color => '784890',
                    item  => 'mysql.Handler_rollback',
                    drawtype  => 'Line',
                },
                {
                    color => 'D1642E',
                    item  => 'mysql.Handler_savepoint',
                    drawtype  => 'Line',
                },
                {
                    color => '487860',
                    item  => 'mysql.Handler_savepoint_rollback',
                    drawtype  => 'Line',
                },
            ],
        },
        {
            name  => 'MySQL Handlers',
            items => [
                {
                    color => '4D4A47',
                    item  => 'mysql.Handler_write',
                    drawtype  => 'Filled',
                },
                {
                    color => 'C79F71',
                    item  => 'mysql.Handler_update',
                    drawtype  => 'Gradient',
                },
                {
                    color => 'BDB8B3',
                    item  => 'mysql.Handler_delete',
                    drawtype  => 'Gradient',
                },
                {
                    color => '8C286E',
                    item  => 'mysql.Handler_read_first',
                    drawtype  => 'Gradient',
                },
                {
                    color => 'BAB27F',
                    item  => 'mysql.Handler_read_key',
                    drawtype  => 'Gradient',
                },
                {
                    color => 'C02942',
                    item  => 'mysql.Handler_read_next',
                    drawtype  => 'Gradient',
                },
                {
                    color => 'FA6900',
                    item  => 'mysql.Handler_read_prev',
                    drawtype  => 'Gradient',
                },
                {
                    color => '5A3D31',
                    item  => 'mysql.Handler_read_rnd',
                    drawtype  => 'Gradient',
                },
                {
                    color => '69D2E7',
                    item  => 'mysql.Handler_read_rnd_next',
                    drawtype  => 'Gradient',
                },
            ],
        },
    ],

    items => {
        'mysql.Aborted_clients' => {
            description => 'Aborted clients',
            store       => 'Delta_simple',

        },

        'mysql.Aborted_connects' => {
            description => 'Aborted connects',
            store       => 'Delta_simple',

        },

        'mysql.Binlog_cache_disk_use' => {
            description => 'Binlog cache disk use',
            store       => 'Delta_simple',
            units       => 'B',

        },

        'mysql.Binlog_cache_use' => {
            description => 'Binlog cache use',
            store       => 'Delta_simple',
            units       => 'B',

        },

        'mysql.Bytes_received' => {
            description => 'Bytes received',
            units       => 'B',
            store       => 'Delta_simple',

        },

        'mysql.Bytes_sent' => {
            description => 'Bytes sent',
            units       => 'B',
            store       => 'Delta_simple',

        },

        'mysql.Com_delete' => {
            description => 'Com delete',
            store       => 'Delta_simple',

        },

        'mysql.Com_delete_multi' => {
            description => 'Com delete multi',
            store       => 'Delta_simple',

        },

        'mysql.Com_insert' => {
            description => 'Com insert',
            store       => 'Delta_simple',

        },

        'mysql.Com_insert_select' => {
            description => 'Com insert select',
            store       => 'Delta_simple',

        },

        'mysql.Com_load' => {
            description => 'Com load',
            store       => 'Delta_simple',

        },

        'mysql.Com_replace' => {
            description => 'Com replace',
            store       => 'Delta_simple',

        },

        'mysql.Com_replace_select' => {
            description => 'Com replace select',
            store       => 'Delta_simple',

        },

        'mysql.Com_select' => {
            description => 'Com select',
            store       => 'Delta_simple',

        },

        'mysql.Com_update' => {
            description => 'Com update',
            store       => 'Delta_simple',

        },

        'mysql.Com_update_multi' => {
            description => 'Com update multi',
            store       => 'Delta_simple',

        },

        'mysql.Connections' => {
            description => 'Connections',
            store       => 'Delta_simple',

        },

        'mysql.Created_tmp_disk_tables' => {
            description => 'Created tmp disk tables',
            store       => 'Delta_simple',

        },

        'mysql.Created_tmp_files' => {
            description => 'Created tmp files',
            store       => 'Delta_simple',

        },

        'mysql.Created_tmp_tables' => {
            description => 'Created tmp tables',
            store       => 'Delta_simple',

        },

        'mysql.Key_read_requests' => {
            description => 'MyISAM Key read requests',
            store       => 'Delta_simple',

        },

        'mysql.Key_reads' => {
            description => 'MyISAM Key reads',
            store       => 'Delta_simple',

        },

        'mysql.Key_write_requests' => {
            description => 'MyISAM Key write requests',
            store       => 'Delta_simple',

        },

        'mysql.Key_writes' => {
            description => 'MyISAM Key writes',
            store       => 'Delta_simple',

        },

        'mysql.Max_used_connections' => {
            description => 'Max used connections',
            store       => 'As_is',

        },

        'mysql.Open_files' => {
            description => 'Open files',
            store       => 'As_is',

        },

        'mysql.Open_tables' => {
            description => 'Open tables',
            store       => 'As_is',

        },

        'mysql.Opened_tables' => {
            description => 'Opened tables',
            store       => 'Delta_simple',

        },

        'mysql.Qcache_free_blocks' => {
            description => 'Qcache free blocks',
            store       => 'As_is',

        },

        'mysql.Qcache_free_memory' => {
            description => 'Qcache free memory',
            store       => 'As_is',
            units       => 'B',

        },

        'mysql.Qcache_hits' => {
            description => 'Qcache hits',
            store       => 'Delta_simple',

        },

        'mysql.Qcache_inserts' => {
            description => 'Qcache inserts',
            store       => 'Delta_simple',

        },

        'mysql.Qcache_lowmem_prunes' => {
            description => 'Qcache lowmem prunes',
            store       => 'Delta_simple',

        },

        'mysql.Qcache_not_cached' => {
            description => 'Qcache not cached',
            store       => 'Delta_simple',

        },

        'mysql.Qcache_queries_in_cache' => {
            description => 'Qcache queries in cache',
            store       => 'As_is',

        },

        'mysql.Qcache_total_blocks' => {
            description => 'Qcache total blocks',
            store       => 'As_is',

        },

        'mysql.Questions' => {
            description => 'Questions',
            store       => 'Delta_simple',

        },

        'mysql.Select_full_join' => {
            description => 'Select full join',
            store       => 'Delta_simple',

        },

        'mysql.Select_full_range_join' => {
            description => 'Select full range join',
            store       => 'Delta_simple',

        },

        'mysql.Select_range' => {
            description => 'Select range',
            store       => 'Delta_simple',

        },

        'mysql.Select_range_check' => {
            description => 'Select range check',
            store       => 'Delta_simple',

        },

        'mysql.Select_scan' => {
            description => 'Select scan',
            store       => 'Delta_simple',

        },

        'mysql.Slave_open_temp_tables' => {
            description => 'Slave open temp tables',
            store       => 'As_is',

        },

        'mysql.Slave_retried_transactions' => {
            description => 'Slave retried transactions',
            store       => 'Delta_simple',

        },

        'mysql.Slow_launch_threads' => {
            description => 'Slow launch threads',
            store       => 'Delta_simple',

        },

        'mysql.Slow_queries' => {
            description => 'Slow queries',
            store       => 'Delta_simple',

        },

        'mysql.Sort_merge_passes' => {
            description => 'Sort merge passes',
            store       => 'Delta_simple',

        },

        'mysql.Sort_range' => {
            description => 'Sort range',
            store       => 'Delta_simple',

        },

        'mysql.Sort_rows' => {
            description => 'Sort rows',
            store       => 'Delta_simple',

        },

        'mysql.Sort_scan' => {
            description => 'Sort scan',
            store       => 'Delta_simple',

        },

        'mysql.Table_locks_immediate' => {
            description => 'Table locks immediate',
            store       => 'Delta_simple',

        },

        'mysql.Table_locks_waited' => {
            description => 'Table locks waited',
            store       => 'Delta_simple',

        },

        'mysql.Threads_cached' => {
            description => 'Threads cached',
            store       => 'As_is',

        },

        'mysql.Threads_connected' => {
            description => 'Threads connected',
            store       => 'As_is',

        },

        'mysql.Threads_created' => {
            description => 'Threads created',
            store       => 'Delta_simple',

        },

        'mysql.Threads_running' => {
            description => 'Threads running',
            store       => 'As_is',

        },

        'mysql.binary_log_space' => {
            description => 'Binary log space',
            store       => 'As_is',

        },

        'mysql.setting.binlog_cache_size' => {
            description => 'Binlog cache size',
            store       => 'As_is',
            interval    => $setting_interval,

        },

        'mysql.current_transactions' => {
            description => 'Current transactions',
            store       => 'As_is',

        },

        'mysql.active_transactions' => {
            description => 'Active transactions',
            store       => 'As_is',

        },

        'mysql.locked_transactions' => {
            description => 'Locked transactions',
            store       => 'As_is',

        },

        'mysql.database_pages' => {
            description => 'Database pages',
            store       => 'As_is',

        },

        'mysql.file_fsyncs' => {
            description => 'File fsyncs',
            store       => 'Delta_simple',

        },

        'mysql.file_reads' => {
            description => 'File reads',
            store       => 'Delta_simple',

        },

        'mysql.file_writes' => {
            description => 'File writes',
            store       => 'Delta_simple',

        },

        'mysql.free_pages' => {
            description => 'Free pages',
            store       => 'As_is',

        },

        'mysql.history_list' => {
            description => 'History list',
            store       => 'As_is',

        },

        'mysql.ibuf_inserts' => {
            description => 'Ibuf inserts',
            store       => 'Delta_simple',

        },

        'mysql.ibuf_merged' => {
            description => 'Ibuf merged',
            store       => 'Delta_simple',

        },

        'mysql.ibuf_merges' => {
            description => 'Ibuf merges',
            store       => 'Delta_simple',

        },

        'mysql.innodb_log_buffer_size' => {
            description => 'InnoDB log buffer size',
            store       => 'As_is',
            units       => 'B',

        },

        'mysql.innodb_open_files' => {
            description => 'InnoDB open files',
            store       => 'As_is',

        },

        'mysql.innodb_transactions' => {
            description => 'InnoDB transactions',
            store       => 'Delta_simple',

        },

        'mysql.log_bytes_flushed' => {
            description => 'Log bytes flushed',
            store       => 'Delta_simple',
            units       => 'B',

        },

        'mysql.log_bytes_written' => {
            description => 'Log bytes written',
            store       => 'Delta_simple',
            units       => 'B',

        },

        'mysql.log_writes' => {
            description => 'Log writes',
            store       => 'Delta_simple',

        },

        'mysql.setting.max_connections' => {
            description => 'Max connections',
            store       => 'As_is',
            interval    => $setting_interval,

        },

        'mysql.modified_pages' => {
            description => 'Modified pages',
            store       => 'As_is',

        },

        'mysql.setting.open_files_limit' => {
            description => 'Open files limit',
            store       => 'As_is',
            interval    => $setting_interval,

        },

        'mysql.os_waits' => {
            description => 'OS waits',
            store       => 'Delta_simple',

        },

        'mysql.pages_created' => {
            description => 'Pages created',
            store       => 'Delta_simple',

        },

        'mysql.pages_read' => {
            description => 'Pages read',
            store       => 'Delta_simple',

        },

        'mysql.pages_written' => {
            description => 'Pages written',
            store       => 'Delta_simple',

        },

        'mysql.pending_aio_log_ios' => {
            description => 'Pending AIO log ios',
            store       => 'As_is',

        },

        'mysql.pending_aio_sync_ios' => {
            description => 'Pending AIO sync ios',
            store       => 'As_is',

        },

        'mysql.pending_buf_pool_flushes' => {
            description => 'Pending buf pool flushes',
            store       => 'As_is',

        },

        'mysql.pending_chkp_writes' => {
            description => 'Pending chkp writes',
            store       => 'As_is',

        },

        'mysql.pending_ibuf_aio_reads' => {
            description => 'Pending ibuf AIO reads',
            store       => 'As_is',

        },

        'mysql.pending_log_flushes' => {
            description => 'Pending log flushes',
            store       => 'As_is',

        },

        'mysql.pending_log_writes' => {
            description => 'Pending log writes',
            store       => 'As_is',

        },

        'mysql.pending_normal_aio_reads' => {
            description => 'Pending normal AIO reads',
            store       => 'As_is',

        },

        'mysql.pending_normal_aio_writes' => {
            description => 'Pending normal AIO writes',
            store       => 'As_is',

        },

        'mysql.setting.pool_size' => {
            description => 'Pool size',
            store       => 'As_is',
            units       => 'B',
            interval    => $setting_interval,

        },

        'mysql.setting.query_cache_size' => {
            description => 'Query cache size',
            store       => 'As_is',
            units       => 'B',
            interval    => $setting_interval,

        },

        'mysql.read_views' => {
            description => 'Read views',
            store       => 'As_is',

        },

        'mysql.relay_log_space' => {
            description => 'Relay log space',
            store       => 'As_is',

        },

        'mysql.rows_deleted' => {
            description => 'Rows deleted',
            store       => 'Delta_simple',

        },

        'mysql.rows_inserted' => {
            description => 'Rows inserted',
            store       => 'Delta_simple',

        },

        'mysql.rows_read' => {
            description => 'Rows read',
            store       => 'Delta_simple',

        },

        'mysql.rows_updated' => {
            description => 'Rows updated',
            store       => 'Delta_simple',

        },

        'mysql.slave_lag' => {
            description => 'Slave lag',
            store       => 'As_is',

        },

        'mysql.slave_running' => {
            description => 'Slave running',
            store       => 'As_is',

        },

        'mysql.slave_stopped' => {
            description => 'Slave stopped',
            store       => 'As_is',

        },

        'mysql.spin_rounds' => {
            description => 'Spin rounds',
            store       => 'Delta_simple',

        },

        'mysql.spin_waits' => {
            description => 'Spin waits',
            store       => 'Delta_simple',

        },

        'mysql.setting.table_cache' => {
            description => 'Table cache',
            store       => 'As_is',
            interval    => $setting_interval,

        },

        'mysql.setting.thread_cache_size' => {
            description => 'Thread cache size',
            store       => 'As_is',
            interval    => $setting_interval,

        },

        'mysql.unflushed_log' => {
            description => 'Unflushed log',
            store       => 'As_is',
            units       => 'B',

        },

        'mysql.State_closing_tables' => {
            description => 'State closing tables',
            store       => 'As_is',

        },

        'mysql.State_copying_to_tmp_table' => {
            description => 'State copying to tmp table',
            store       => 'As_is',

        },

        'mysql.State_end' => {
            description => 'State end',
            store       => 'As_is',

        },

        'mysql.State_freeing_items' => {
            description => 'State freeing items',
            store       => 'As_is',

        },

        'mysql.State_init' => {
            description => 'State init',
            store       => 'As_is',

        },

        'mysql.State_locked' => {
            description => 'State locked',
            store       => 'As_is',

        },

        'mysql.State_login' => {
            description => 'State login',
            store       => 'As_is',

        },

        'mysql.State_preparing' => {
            description => 'State preparing',
            store       => 'As_is',

        },

        'mysql.State_reading_from_net' => {
            description => 'State reading from net',
            store       => 'As_is',

        },

        'mysql.State_sending_data' => {
            description => 'State sending data',
            store       => 'As_is',

        },

        'mysql.State_sorting_result' => {
            description => 'State sorting result',
            store       => 'As_is',

        },

        'mysql.State_statistics' => {
            description => 'State statistics',
            store       => 'As_is',

        },

        'mysql.State_updating' => {
            description => 'State updating',
            store       => 'As_is',

        },

        'mysql.State_writing_to_net' => {
            description => 'State writing to net',
            store       => 'As_is',

        },

        'mysql.State_none' => {
            description => 'State none',
            store       => 'As_is',

        },

        'mysql.State_other' => {
            description => 'State other',
            store       => 'As_is',

        },

        'mysql.Handler_commit' => {
            description => 'Handler commit',
            store       => 'Delta_simple',

        },

        'mysql.Handler_delete' => {
            description => 'Handler delete',
            store       => 'Delta_simple',

        },

        'mysql.Handler_discover' => {
            description => 'Handler discover',
            store       => 'Delta_simple',

        },

        'mysql.Handler_prepare' => {
            description => 'Handler prepare',
            store       => 'Delta_simple',

        },

        'mysql.Handler_read_first' => {
            description => 'Handler read first',
            store       => 'Delta_simple',

        },

        'mysql.Handler_read_key' => {
            description => 'Handler read key',
            store       => 'Delta_simple',

        },

        'mysql.Handler_read_next' => {
            description => 'Handler read next',
            store       => 'Delta_simple',

        },

        'mysql.Handler_read_prev' => {
            description => 'Handler read prev',
            store       => 'Delta_simple',

        },

        'mysql.Handler_read_rnd' => {
            description => 'Handler read rnd',
            store       => 'Delta_simple',

        },

        'mysql.Handler_read_rnd_next' => {
            description => 'Handler read rnd next',
            store       => 'Delta_simple',

        },

        'mysql.Handler_rollback' => {
            description => 'Handler rollback',
            store       => 'Delta_simple',

        },

        'mysql.Handler_savepoint' => {
            description => 'Handler savepoint',
            store       => 'Delta_simple',

        },

        'mysql.Handler_savepoint_rollback' => {
            description => 'Handler savepoint rollback',
            store       => 'Delta_simple',

        },

        'mysql.Handler_update' => {
            description => 'Handler update',
            store       => 'Delta_simple',

        },

        'mysql.Handler_write' => {
            description => 'Handler write',
            store       => 'Delta_simple',

        },

        'mysql.additional_pool_alloc' => {
            description => 'Additional pool alloc',
            store       => 'As_is',
            units       => 'B',

        },

        'mysql.total_mem_alloc' => {
            description => 'Total mem alloc',
            store       => 'As_is',
            units       => 'B',

        },

        'mysql.hash_index_cells_total' => {
            description => 'Hash index cells total',
            store       => 'As_is',

        },

        'mysql.hash_index_cells_used' => {
            description => 'Hash index cells used',
            store       => 'As_is',

        },

        'mysql.innodb_lock_structs' => {
            description => 'InnoDB lock structs',
            store       => 'As_is',

        },

        'mysql.innodb_lock_wait_secs' => {
            description => 'InnoDB lock wait secs',
            store       => 'As_is',

        },

        'mysql.innodb_tables_in_use' => {
            description => 'InnoDB tables in use',
            store       => 'As_is',

        },

        'mysql.innodb_locked_tables' => {
            description => 'InnoDB locked tables',
            store       => 'As_is',

        },

        'mysql.uncheckpointed_bytes' => {
            description => 'Uncheckpointed bytes',
            store       => 'As_is',
            units       => 'B',

        },

        'mysql.innodb_sem_waits' => {
            description => 'InnoDB sem waits',
            store       => 'As_is',

        },

        'mysql.innodb_sem_wait_time_ms' => {
            description => 'InnoDB sem wait time ms',
            store       => 'As_is',

        },

        'mysql.ibuf_cell_count' => {
            description => 'Ibuf cell count',
            store       => 'As_is',

        },

        'mysql.ibuf_used_cells' => {
            description => 'Ibuf used cells',
            store       => 'As_is',

        },

        'mysql.ibuf_free_cells' => {
            description => 'Ibuf free cells',
            store       => 'As_is',

        },

        'mysql.adaptive_hash_memory' => {
            description => 'Adaptive hash memory',
            store       => 'As_is',
            units       => 'B',

        },

        'mysql.page_hash_memory' => {
            description => 'Page hash memory',
            store       => 'As_is',
            units       => 'B',

        },

        'mysql.dictionary_cache_memory' => {
            description => 'Dictionary cache memory',
            store       => 'As_is',
            units       => 'B',

        },

        'mysql.file_system_memory' => {
            description => 'File system memory',
            store       => 'As_is',
            units       => 'B',

        },

        'mysql.lock_system_memory' => {
            description => 'Lock system memory',
            store       => 'As_is',
            units       => 'B',

        },

        'mysql.recovery_system_memory' => {
            description => 'Recovery system memory',
            store       => 'As_is',
            units       => 'B',

        },

        'mysql.thread_hash_memory' => {
            description => 'Thread hash memory',
            store       => 'As_is',
            units       => 'B',

        },

        'mysql.Key_buf_bytes_unflushed' => {
            description => 'MyISAM Key buf bytes unflushed',
            store       => 'As_is',
            units       => 'B',

        },

        'mysql.Key_buf_bytes_used' => {
            description => 'MyISAM Key buf bytes used',
            store       => 'As_is',
            units       => 'B',

        },

        'mysql.setting.key_buffer_size' => {
            description => 'MyISAM key buffer size',
            store       => 'As_is',
            units       => 'B',
            interval    => $setting_interval,
        },

        'mysql.Innodb_row_lock_waits' => {
            description => 'Innodb row lock waits',
            store       => 'As_is',

        },

        'mysql.Innodb_row_lock_time' => {
            description => 'Innodb row lock time',
            store       => 'As_is',

        },

        'proc.num[mysqld]' => {
            description => 'MySQL Processes',
            store       => 'As_is',
            interval    => 60,
        }
    },

    triggers => [
        {
            description => 'Process mysqld not running on {HOSTNAME}',
            expression  => '{Template_MySQL:proc.num[mysqld].last(0)}=0',
            severity    => 'Disaster',
        },
        {
            description => 'Slave lag more than 10m over 10m on {HOSTNAME}',
            expression  => '{Template_MySQL:mysql.slave_lag.avg(600)}>600',
            severity    => 'High',
            depends_on  => [ 'Process mysqld not running on {HOSTNAME}' ],
        },
        {
            description => 'Slave lag more than 5m over 10m on {HOSTNAME}',
            expression  => '{Template_MySQL:mysql.slave_lag.avg(600)}>300',
            severity    => 'Average',
            depends_on  => [ 'Slave lag more than 10m over 10m on {HOSTNAME}', 'Process mysqld not running on {HOSTNAME}' ],
        },
        {
            description => 'Slave is stopped on {HOSTNAME}',
            expression  => '{Template_MySQL:mysql.slave_running.last(0)}=-1|{Template_MySQL:mysql.slave_stopped.last(0)}=-1',
            severity    => 'High',
            depends_on  => [ 'Process mysqld not running on {HOSTNAME}' ],
        },
        {
            description => 'More than 500 threads on {HOSTNAME}',
            expression  => '{Template_MySQL:mysql.Threads_connected.last(0)}>500',
            severity    => 'Average',
            depends_on  => [ 'Process mysqld not running on {HOSTNAME}' ],
        },
        {
            description => 'Server {HOSTNAME} is waiting on table locks',
            expression  => '{Template_MySQL:mysql.Table_locks_waited.delta(300)}>10',
            severity    => 'Average',
            depends_on  => [ 'Process mysqld not running on {HOSTNAME}' ],
        },
        {
            description => 'InnoDB lock structures more than 30 in 5m on {HOSTNAME}',
            expression  => '{Template_MySQL:mysql.innodb_lock_structs.delta(300)}>30',
            severity    => 'Average',
            depends_on  => [ 'Process mysqld not running on {HOSTNAME}' ],
        },
        {
            description => 'InnoDB uncheckpointed bytes in the last 10m > 25MB on {HOSTNAME}',
            expression  => '{Template_MySQL:mysql.uncheckpointed_bytes.delta(600)}>25M',
            severity    => 'Average',
            depends_on  => [ 'Process mysqld not running on {HOSTNAME}' ],
        },
        {
            description => 'Thread in state Copying_to_tmp_table for more than 6min on {HOSTNAME}',
            expression  => '({TRIGGER.VALUE}=0&{Template_MySQL:mysql.State_copying_to_tmp_table.count(360,1,"ge")}>2)
                           |({TRIGGER.VALUE}=1&{Template_MySQL:mysql.State_copying_to_tmp_table.count(360,1,"ge")}>0)',
            severity    => 'Average',
        },
    ],

    dependencies => [
    ],

    macros => [],
};

