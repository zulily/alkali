{# Could move this to pillar and a for loop, but there are only a few settings
   and keeping this as simple as possible for now.  This state file
   should not be called directly, it is included by init.sls
#}

{% set nf_conntrack_hashsize = 24576 %}

{# Only active after a reboot #}
/etc/modprobe.d/iptables.conf:
   file.managed:
     - source: salt://iptables-persistent/files/iptables.conf
     - template: jinja
     - context:
       nf_conntrack_hashsize: {{ nf_conntrack_hashsize }}
     - user: root
     - group: root
     - mode: 644
     - watch_in:
       - service: iptables-persistent

{# Set dynamically #}
"echo {{ nf_conntrack_hashsize }} > /sys/module/nf_conntrack/parameters/hashsize":
  cmd.wait:
    - watch:
      - file: /etc/modprobe.d/iptables.conf

net.netfilter.nf_conntrack_max:
  sysctl.present:
    - value: 2359296
    - require:
      - service: iptables-persistent

net.netfilter.nf_conntrack_tcp_timeout_time_wait:
  sysctl.present:
    - value: 30
    - require:
      - service: iptables-persistent

net.netfilter.nf_conntrack_generic_timeout:
  sysctl.present:
    - value: 120
    - require:
      - service: iptables-persistent

net.netfilter.nf_conntrack_tcp_timeout_fin_wait:
  sysctl.present:
    - value: 15
    - require:
      - service: iptables-persistent

net.netfilter.nf_conntrack_tcp_timeout_close_wait:
  sysctl.present:
    - value: 15
    - require:
      - service: iptables-persistent

net.netfilter.nf_conntrack_tcp_timeout_established:
  sysctl.present:
    - value: 86400
    - require:
      - service: iptables-persistent
