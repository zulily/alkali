provision:
  'in_provisioning:True':
    - match: grain
    - postfix
    - aliases
    - apt
    - apt-sources
    - base-packages
    - disy
    - dnsmasq-cache
    - hosts-block
    - iptables-persistent
    #- kernel-install
    - limits
    - motd
    - rsyslog-client
    - sysctl
    - timezone
    - provision-final # This should be last in the list
    # DO NOT PUT ADDITIONAL TARGETS IN THIS FILE

