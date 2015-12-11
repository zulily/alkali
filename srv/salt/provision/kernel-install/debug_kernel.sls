{# Install a debug kernel, generally into /usr/lib/debug/boot/ #}
{% set default_kernel_version = '3.13.0-52-generic-dbgsym' %}

{% set kernel_version = grains['kernel_version']|default(default_kernel_version) %}


linux_kernel:
  pkg.installed:
    - pkgs:
      - linux-image-{{ kernel_version }}
    - hold: False

