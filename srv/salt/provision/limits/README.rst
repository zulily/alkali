limits
======

The limits formula is capable of maintaining both the limits.conf file and
limits.d/\*.conf files.  This is all handled in init.sls, but it could quite
easily be split up into separate states if desired.  Currently at provision
time, it is only maintaining low-step-numbered limits.d files.

For any customizations, the pillar data must be modified.

Note that no clean-up occurs, so if a step section is removed from the pillar
data after a run, a subsequent run will not remove the step file.
