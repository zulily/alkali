{% if salt['pillar.get']('hosts_block', False) %}
{# Only run these states if necessary pillar data exists #}

/etc/hosts:
  file.managed:
    - source: salt://hosts-block/files/hosts
    - user: root
    - group: root
    - mode: 644
    - template: jinja

/etc/hosts_blockreplace:
  file.blockreplace:
    - name: /etc/hosts
    - append_if_not_found: True
    - show_changes: True
    - marker_start: "# Begin hosts-block-managed entries -- DO NOT EDIT THIS SECTION"
    - marker_end: "# End hosts-block-managed entries"

hosts_file_{{ grains['host'] }}_accumulated:
  file.accumulated:
    - filename: /etc/hosts
    - text: |

{%- for subsection in salt['pillar.get']('hosts_block', []) %}
  {%- for header, entries in subsection.iteritems() %}

        # {{ header }}
    {%- for entry in entries %}
      {%- for ip, names in entry.iteritems() -%}
        {%- if names|length > 0 %}
        {{ ip }}{% for host in names %}    {{ host }}{% endfor %}
        {%- endif -%}
      {%- endfor -%}
    {% endfor -%}
  {% endfor %}
{% endfor %}
    - require_in:
      - file: /etc/hosts_blockreplace


{% endif %}
