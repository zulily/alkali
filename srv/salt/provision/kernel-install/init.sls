{% set default_kernel_version = '3.13.0-71-generic' %}

{% set kernel_version = grains['kernel_version']|default(default_kernel_version) %}

/etc/default/grub.d/50-cloudimg-settings.cfg:
  file.absent:
    - require_in:
      - cmd: update_grub

linux_kernel:
  pkg.installed:
    - pkgs:
      - linux-image-{{ kernel_version }}
      - linux-image-extra-{{ kernel_version }}
      - linux-headers-{{ kernel_version }}
    - hold: True


override_file:
  file.managed:
    - name: /etc/default/grub.d/99_overrides.cfg
    - source: salt://kernel-install/files/99_overrides.cfg
    - template: jinja
    - require:
      - pkg: linux_kernel
    - context:
      kernel_version: {{ kernel_version }}
    - makedirs: True
    - dir_mode: 755


update_grub:
  cmd.run:
    - name: /usr/sbin/update-grub
    - watch:
      - file: override_file


{# Remove the override file after update-grub is run so future upgrades will select
   the proper kernel automatically in the grub.cfg #}
remove_overrides:
  file.absent:
    - name: /etc/default/grub.d/99_overrides.cfg
    - require:
      - cmd: update_grub

