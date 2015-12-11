{% from "postfix/map.jinja" import postfix with context %}

{{ postfix.package_name }}:
  pkg:
    - installed
  service.running:
    - enable: True
    - require:
      - pkg: {{ postfix.package_name }}
    - watch:
      - file: {{ postfix.postfix_conf_dir }}*


{{ postfix.postfix_conf_dir }}main.cf:
  file.managed:
    - source: 'salt://postfix/files/main.cf'
    - user: root
    - group: root
    - mode: 644
    - template: jinja

{{ postfix.postfix_conf_dir }}master.cf:
  file.managed:
    - source: 'salt://postfix/files/master.cf'
    - user: root
    - group: root
    - mode: 644
    - template: jinja
