sysctl
======

Set and apply sysctl.conf settings.  The default pillar
used by this state file contains defaults for all systems,
as well as targeted_defaults which have a few obvious
example settings for systems running services like mongo,
but the targeted settings are only applied if a
function_class grain is properly set.

For example, setting function_class to redis will receive
all 'default' pillar settings, plus any redis targeted
default settings, which override or extend the defaults.

To set the function_class grain on a minion, using grains.setval
is one option:

salt-call grains.setval function_class mariadb
