#!/bin/bash
#
# current_config.sh
#   Created:    03/01/2016
#   Author:     Diego Montero
#   
#   Description:
#       This script return the current squid3 configuration.
#       (psaConfigs/psaconf)
# 
# This script is called by the PSA API when the PSA's current runtime configuration is requested.
# 
# Return value: 
# Current configuration
#

COMMAND_OUTPUT="$(cat /etc/ipsec.conf)"
printf '%s\n' "${COMMAND_OUTPUT[@]}"
exit 1;
