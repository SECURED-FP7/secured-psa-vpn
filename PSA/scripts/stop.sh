#!/bin/bash
#
# stop.sh
#   Created:    03/01/2016
#   Author:     Diego Montero
#   
#   Description:
#       This script stops squid3 and clear the configuration environmet.
# 
# This script is called by the PSA API when the PSA is requested to be stopped.
# 

ip route flush cache

##########################################################
echo "flusing ebtables"
ebtables -F
ebtables -X
for T in filter nat broute; do   ebtables -t $T -F;   ebtables -t $T -X; done
ebtables -P INPUT ACCEPT
ebtables -P FORWARD ACCEPT
ebtables -P OUTPUT ACCEPT

echo "stopping ipsec"
ipsec stop

echo "PSA Stopped"
exit 1;

