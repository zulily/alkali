{% from "limits/map.jinja" import limits with context %}

{{ limits.limits_conf }}:
  file.managed:
    - source: {{ limits.limits_conf_src }}
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
      settings: {{ salt['pillar.get']('limits:conf') }}

{% for limits_d_step in salt['pillar.get']('limits:d') %}
  {% for step_name, settings in limits_d_step.iteritems() %}
{{ limits.limits_d }}{{ step_name }}.conf:
  file.managed:
    - source: {{ limits.limits_d_conf_src }}
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
      settings: {{ settings }}
  {% endfor %}
{% endfor %}
