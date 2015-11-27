#!/bin/bash
# Example usage:
#   $ facebook-ips.sh | bash -

# Get iptables rules to block facebook:
whois -h whois.radb.net '!gAS32934' | tr " " "\n" | sed 's/^/iptables -A OUTPUT -p tcp -d /g'

# Get ufw rules to block facebook:
#whois -h whois.radb.net '!gAS32934' | tr " " "\n" | sed 's/^/ufw reject out to /g'

