{# Get the targeted defaults #}
{%
    set disy_overrides = salt['grains.filter_by'](
        salt['pillar.get']('disy:targeted_defaults', {}),
        grain='function_class')
%}

{# Get the defaults, then merge the targeted defaults on top #}
{%
    set disy_settings = salt['grains.filter_by'](
        salt['pillar.get']('disy:defaults', {}),
        grain='function_class', merge=disy_overrides)
%}

{# Apply disy states state for merged settings. #}
{% for path, settings in disy_settings.iteritems() %}
{{ path }}:
  file.{{ disy_settings[path]['operation'] }}:
    {{ disy_settings[path]['parameters']|yaml }}
{% endfor %}

