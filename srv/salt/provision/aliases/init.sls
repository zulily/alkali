{% from "aliases/map.jinja" import aliases with context %}

{{ aliases.aliases }}:
  file.managed:
    - source: {{ aliases.aliases_src }}
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - pkg: {{ aliases.postfix_pkg }}

run-newaliases:
  cmd.wait:
    - name: {{ aliases.newaliases_bin }}
    - watch:
      - file: {{ aliases.aliases }}
