#!/bin/bash
#
# start.sh
#   Created:    03/01/2016
#   Author:     Diego Montero
#
#   Description:
#       Start script for the PSA-squid
#
# This script is called by the PSA API when the PSA is requested to be started.

# Load PSA's current configuration

##############################################################

ipsec stop

ipsec start

sleep 1

if P=$(ipsec status psa | grep INSTALLED)
then
    echo "ipsec already started"
    exit 1
else
    ipsec up psa
    echo "ipsec started"
fi

exit 1;

