{% from "rsyslog-client/map.jinja" import rsyslog with context %}

{{ rsyslog.package_name }}:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - require:
      - pkg: {{ rsyslog.package_name }}
    - watch:
      - file: {{ rsyslog.rsyslog_d }}*

{{ rsyslog.rsyslog_d }}99-remote.conf:
  file.managed:
    - source: 'salt://rsyslog-client/files/99-remote.conf'
    - user: root
    - group: root
    - mode: 644
    - template: jinja

{# This limits out-of-order messages #}
{{ rsyslog.rsyslog_d }}99-RepeatedMsgReduction.conf:
  file.managed:
    - source: 'salt://rsyslog-client/files/99-RepeatedMsgReduction.conf'
    - user: root
    - group: root
    - mode: 644
    - template: jinja

