disable-unattended-upgrades:
  file.replace:
    - name: /etc/apt/apt.conf.d/50unattended-upgrades
    - pattern: '\t"\${distro_id}:\${distro_codename}-security";'
    - repl: //   "${distro_id}:${distro_codename}-security";

disable-unattended-upgrades-2:
  file.append:
    - name: /etc/apt/apt.conf.d/10periodic
    - text: APT::Periodic::Unattended-Upgrade "0";
    - makedirs: True
