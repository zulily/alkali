{# Get the targeted defaults #}
{%
    set sysctl_overrides = salt['grains.filter_by'](
        salt['pillar.get']('sysctl:targeted_defaults', {}),
        grain='function_class')
%}

{# Get the defaults, then merge the targeted defaults on top #}
{%
    set sysctl_settings = salt['grains.filter_by'](
        salt['pillar.get']('sysctl:defaults', {}),
        grain='function_class', merge=sysctl_overrides)
%}

{# Apply sysctl.present state for merged settings. #}
{% for setting_name, setting_value in sysctl_settings.iteritems() %}
{{ setting_name }}:
  sysctl.present:
    - value: {{ setting_value }}
{% endfor %}

