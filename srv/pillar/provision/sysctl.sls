sysctl:
    targeted_defaults:
        # Common examples for various function_classes
        mariadb:
            vm.swappiness: 0
        mongo:
            vm.zone_reclaim_mode: 0
        redis:
            vm.overcommit_memory: 0
    defaults:
        # Example settings, customize as necessary.
        default:
            fs.file-max: 196608
            kernel.core_uses_pid: 1
            kernel.msgmax: 65536
            kernel.msgmnb: 65536
            kernel.panic: 1
            # Current default, may not make sense on all systems...
            kernel.shmall: 4294967296
            # Current default, may not make sense on all systems...
            kernel.shmmax: 68719476736
            kernel.sysrq: 1
            net.core.netdev_max_backlog: 50000
            net.core.optmem_max: 40960
            net.core.rmem_default: 16777216
            net.core.rmem_max: 16777216
            net.core.wmem_default: 16777216
            net.core.wmem_max: 16777216
            net.ipv4.conf.all.arp_ignore: 1
            net.ipv4.conf.default.accept_source_route: 0
            net.ipv4.conf.default.rp_filter: 1
            net.ipv4.conf.eth0.arp_announce: 2
            net.ipv4.conf.eth0.arp_ignore: 1
            {% if 'eth1' in grains['ip_interfaces'].keys() -%}
            net.ipv4.conf.eth1.arp_announce: 2
            net.ipv4.conf.eth1.arp_ignore: 1
            {% endif -%}
            net.ipv4.ip_forward: 0
            net.ipv4.ip_local_port_range: 12000 61000
            net.ipv4.tcp_fin_timeout: 20
            net.ipv4.tcp_max_syn_backlog: 30000
            net.ipv4.tcp_max_tw_buckets: 2000000
            net.ipv4.tcp_rmem: 4096 87380 16777216
            net.ipv4.tcp_slow_start_after_idle: 0
            net.ipv4.tcp_syncookies: 1
            net.ipv4.tcp_tw_reuse: 1
            net.ipv4.tcp_wmem: 4096 65536 16777216
            net.ipv6.conf.all.disable_ipv6: 1
            net.ipv6.conf.default.disable_ipv6: 1
            net.ipv6.conf.lo.disable_ipv6: 1
            vm.overcommit_memory: 1
            vm.swappiness: 10
