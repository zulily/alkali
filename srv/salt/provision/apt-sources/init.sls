{% set codename = salt['cmd.run']("lsb_release -c | awk '{ print $2 }'") %}

# We are using sources.list.d, zero-out sources.list
/etc/apt/sources.list:
  file.managed:
    - contents: ''

# Repos to include
{{ codename }}:
  pkgrepo.managed:
    - name: deb http://archive.ubuntu.com/ubuntu/ {{ codename }} main restricted universe
    - file: /etc/apt/sources.list.d/{{ codename }}.list
    - refreshdb: True

{{ codename }}-security:
  pkgrepo.managed:
    - name: deb http://archive.ubuntu.com/ubuntu/ {{ codename }}-security main restricted universe
    - file: /etc/apt/sources.list.d/{{ codename }}_security.list
    - refreshdb: True

{{ codename }}-updates:
  pkgrepo.managed:
    - name: deb http://archive.ubuntu.com/ubuntu/ {{ codename }}-updates main restricted universe
    - file: /etc/apt/sources.list.d/{{ codename }}_updates.list
    - refreshdb: True


