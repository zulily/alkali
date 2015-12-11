kernel-install
==============

Not included in the top.sls by default, but allows for installation of
a specific kernel and setting it as the default for subsequent reboots.

To select the kernel version, a 'kernel_version' grain must be set on a
per-minion basis.  For example:

salt-call grains.setval kernel_version 3.13.0-43-generic

Note that both the init.sls and kernel_debug.sls state files allow for a
default kernel version to be set, which will be used if the grain is not set.
