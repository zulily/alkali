# Matching on the in_provisioning grain is an option, but single state runs post-provision
# would not have access to pillar data.
provision:
  '*':
    - aliases
    - disy
    - dnsmasq-cache
    - hosts-block
    - limits
    - sysctl
