#!/bin/bash

BAT0=/sys/class/power_supply/BAT0   # Secondary
BAT1=/sys/class/power_supply/BAT1   # Primary

STATUS=$(cat ${BAT1}/status)
B0CAP=$(cat ${BAT0}/capacity)
B1CAP=$(cat ${BAT1}/capacity)
CHRG=$((($B0CAP + $B1CAP)/2)) 

case ${STATUS} in
    "Full") ICON=""; CHRG="100" ;;
    "Not charging") ICON=""; CHRG="100" ;;
    "Charging")
        case ${CHRG} in
            9*) ICON="󰂋" ;;
            8*) ICON="󰂊" ;;
            7*) ICON="󰢞" ;;
            6*) ICON="󰂉" ;;
            5*) ICON="󰢝" ;;
            4*) ICON="󰂈" ;;
            3*) ICON="󰂇" ;;
            2*) ICON="󰂆" ;;
            1*) ICON="󰢜" ;;
        esac ;;
    "Discharging")
        case ${CHRG} in
            9*) ICON="󰂂" ;;
            8*) ICON="󰂁" ;;
            7*) ICON="󰂀" ;;
            6*) ICON="󰁿" ;;
            5*) ICON="󰁾" ;;
            4*) ICON="󰁽" ;;
            3*) ICON="󰁼" ;;
            2*) ICON="󰁻" ;;
            1*) ICON="󰁺" ;;
        esac ;;
esac

echo "${ICON} ${CHRG}% "
