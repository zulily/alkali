======
alkali
======

alkali is a collections of SaltStack states and pillar data that provide *just the basics* for provisioning Linux instances
that may be built upon. alkali is a starter kit of sorts, to help new users to SaltStack get up-and-running
quickly with the most commonly used, core packages.

Discussion
==========

Salt state and pillar trees reside within this repository under the srv directory.  These trees are meant to
be run within a "provision" environment, and only when a special grain is set to True:  **in_provisioning**.

The provision environment is intended to span across minions that are part of any salt environment.
It contains a very common collection of states and is generally static, the intent is that these states
will only be executed a single time like so:

::

  salt -G 'in_provisioning:True' state.highstate saltenv=provision -l debug

States in other environments run post-provision phase may change settings previously applied.  The
provision phase is not intended to meet the precise requirements of all possible instance types, but rather to
apply useful defaults that may be extended and overridden from more specific environments and targeting.

While very uncommon, it is ocassionally necessary to re-run an updated provision environment state file.
If the dnsmasq_cache states are updated for example:

::

  salt '*.dev.*' state.sls dnsmasq_cache saltenv=provision -l debug


Getting Started
===============
+ These states are currently only compatible with debian-based systems, with a few specific
  states ony compatible with Ubuntu.  They have only been tested and are known
  to work on Ubuntu 14.04 and some later Ubuntu releases.

+ Provision states will work with a master minion setup in which the saltenv may
  be specified as an argument to the salt or salt-call commands.

+ Clone this repository and copy relevant directories to /srv/salt/provision and
  /srv/pillar/provision

+ Bring up any instances that will be part of the cluster, with recent
  base Ubuntu installs.

+ Make sure to have a base environment, with an empty top.sls file at a minimum,
  /srv/salt/base and /srv/pillar/base

+ Configure file_roots and pillar_roots, for example:

::

  file_roots:
    base:
      - /srv/salt/base
    provision:
      - /srv/salt/provision

  pillar_roots:
    base:
      - /srv/pillar/base
    provision:
      - /srv/pillar/provision



+ Any minions to be provisioned must have the in_provisioning grain set:

::

  salt-call grains.setval in_provisioning True

+ Provision minions.  From the master:

::

  salt -G 'in_provisioning:True' state.highstate saltenv=provision -l debug

Compound targeting may be useful in some scenarios.

+ Once provisioned, removing the in_provisioning grain is recommended.  This

::

  salt-call grains.delval in_provisioning destructive=True

Included States
===============
All of the included states have a README.rst file with additional details, but to summarize:

.. contents::
       :local:

``aliases``
-----------
/etc/aliases management, based on pillar data.

``apt``
-------
States for configuring apt.

``apt-sources``
---------------
Management of apt sources.list.d files. Ubuntu-specific by default.

``base-packages``
-----------------
A list of packages to install at provision time, which require no configuration management.

``disy``
--------
Creates symlinks and directories based on pillar settings.

``dnsmasq-cache``
-----------------
Installs and configures dnsmasq as a local caching daemon.

``hosts-block``
---------------
Management of /etc/hosts to ensure consistency, utilizes pillar data.

``iptables-persistent``
-----------------------
Installs iptables and performs tuning, but does not apply a ruleset.

``kernel-install``
------------------
Provides a simple mechanism for installing a specific kernel version
and setting it to be the grub default.  Typically run ad-hoc only.

``limits``
----------
Provides pillar-driven limits.conf and limits.conf.d management.

``motd``
--------
Management of motd legalese to be displayed at login.

``postfix``
-----------
Basic postfix installation and configuration for a smarthost setup.

``provision-final``
-------------------
The last state file to be run, creates /root/.alkali_provisioned.txt which indicates
when the provision highstate was run.

``rsyslog-client``
------------------
Brings up rsyslog with logging to a centralized syslog server.

``sysctl``
----------
Pillar-driven kernel tuning, with reasonable defaults and host-function-specific
setting capabilities.

``timezone``
------------
Sets the timezone.


Other States
============
A few noteworthy formulas and states that are absent and will most likely
be useful to a wide audience:

* ntp - Using the SaltStack community formula is recommended
* openssh - Using the SaltStack community formula is recommended
* Log shipping and monitoring agents - nrpe, zabbix, the splunk forwarder, newrelic, etc.
* Account management-related states
* resolvconf management

ToDo / Known Issues
===================
+ Add support for non-Debian-based distributions and better non-Ubuntu-specific support in general.

License
=======

Apache License, version 2.0.  Please see LICENSE.
