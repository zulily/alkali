{% set datetime = salt['cmd.run']('date') %}
/root/.alkali_provisioned.txt:
  file.managed:
    - source: salt://provision-final/files/alkali_provisioned.txt
    - user: root
    - group: root
    - mode: 444
    - template: jinja
    - context:
      'datetime': {{ datetime }}
