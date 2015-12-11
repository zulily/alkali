iptables-persistent
===================

Installs iptables-persistent and applies basic tuning.  Custom rule management
is not handled by these states.

iptables-persistent states will only be applied if the iptables_enabled
grain is set to True:

  salt-call grains.setval iptables_enabled True

To prevent these states from being applied:

  salt-call grains.setval iptables_enabled False

To fully remove the grain (generally unnecessary):

  salt-call grains.delval iptables_enabled destructive=True

