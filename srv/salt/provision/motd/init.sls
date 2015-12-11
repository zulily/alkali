motd:
  file.managed:
    {% if grains['os_family'] == 'Debian' %}
    - name: /etc/update-motd.d/10-help-text
    - source: salt://motd/files/10-help-text
    {% endif %}
