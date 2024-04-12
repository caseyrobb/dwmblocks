#!/bin/bash

SSID=$(nmcli -t -f active,ssid dev wifi | grep -E '^yes' | awk -F':' '{print $2}')

if [ -z "${SSID}" ]; then
    echo -e "󰖪 Not Connected"
else
    echo -e "  ${SSID}"
fi
