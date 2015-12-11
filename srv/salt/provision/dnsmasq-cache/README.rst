dnsmasq-cache
=============

Installs and configures dnsmasq as a local caching daemon.

Make sure to set 127.0.0.1 as the first nameserver in /etc/resolv.conf
(not handled by these states) or the local dnsmasq instance will not be utilized.

dnsmasq main configuration settings are customizable in the pillar data.
