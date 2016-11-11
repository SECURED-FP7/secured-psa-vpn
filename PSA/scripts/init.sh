#!/bin/bash
#
# init.sh
#   Created:    03/01/2016
#   Author:     Diego Montero
#
#   Description:
#

# 

sysctl net.ipv4.ip_forward=1
sysctl net.ipv6.conf.all.forwarding=1

ipsec stop

echo "flushing routing cache"
ip route flush cache

## interface facing clients
CLIENT_IFACE=eth0

## interface facing Internet
INET_IFACE=eth1

ebtables -P FORWARD DROP
ebtables -A FORWARD -p IPv4 -j ACCEPT
ebtables -A FORWARD -p ARP -j ACCEPT
ebtables -t broute -A BROUTING -i $CLIENT_IFACE -p ipv4 -j redirect --redirect-target DROP
#ebtables -t broute -A BROUTING -i $INET_IFACE -p ipv4 -j redirect --redirect-target DROP

# Parse json and set the ipsec configuration 
JSON_CONF_FILE=/home/psa/pythonScript/psaConfigs/psaconf
DEFAULT_CONF_FILE=/home/psa/pythonScript/defaultIpsecConf
IPSEC_CONF_FILE=/etc/ipsec.conf
python /home/psa/pythonScript/parseConfig.py $JSON_CONF_FILE $DEFAULT_CONF_FILE $IPSEC_CONF_FILE

echo 1;
exit 1;
