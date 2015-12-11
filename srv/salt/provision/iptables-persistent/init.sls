{% if 'iptables_enabled' in grains and grains['iptables_enabled'] %}

iptables-persistent:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - require:
      - pkg: iptables-persistent
    - watch:
      - file: /etc/iptables/rules.v4

/etc/iptables/rules.v4:
  file.managed:
    - source: salt://iptables-persistent/files/rules.v4
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: iptables-persistent

include:
  - iptables-persistent/tuning


{% endif %}

