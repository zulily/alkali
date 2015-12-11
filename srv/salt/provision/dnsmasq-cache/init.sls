dnsmasq:
  pkg:
    - installed
  service:
    - running


/etc/dnsmasq.conf:
  file.managed:
    - source: salt://dnsmasq-cache/files/dnsmasq.conf
    - template: jinja
    - watch_in:
      - service: dnsmasq
    - require:
      - pkg: dnsmasq


/etc/dnsmasq.d/00_main.conf:
  file.managed:
    - source: salt://dnsmasq-cache/files/00_main.conf
    - template: jinja
    - watch_in:
      - service: dnsmasq
    - require:
      - file: /etc/dnsmasq.conf
    - context:
      main_settings: {{ salt['pillar.get']('dnsmasq_cache:main', []) }}


/etc/default/dnsmasq:
  file.managed:
    - source: salt://dnsmasq-cache/files/etc_default_dnsmasq
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - watch_in:
      - service: dnsmasq
    - require:
      - file: /etc/dnsmasq.conf
