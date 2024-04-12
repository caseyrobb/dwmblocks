#!/bin/bash

. ~/.local/bin/nord.sh

WEATHER="${XDG_CACHE_HOME:-$HOME/.cache}/weather"
APIKEY=XXXXXX

LAT=48.30
LON=-123.30

curl -sf "https://api.openweathermap.org/data/2.5/weather?lat=${LAT}&lon=${LON}&appid=${APIKEY}&units=metric" > $WEATHER || exit 1

CURRTEMP=$(jq -r '.main.temp' < $WEATHER)
HITEMP=$(jq -r '.main.temp_max' < $WEATHER)
LOWTEMP=$(jq -r '.main.temp_min' < $WEATHER)
HUMIDITY=$(jq -r '.main.humidity' < $WEATHER)
WCODE=$(jq -r '.weather[].id' < $WEATHER)
CURRTEMP=$(printf "%.1f" "${CURRTEMP}")

case $BLOCK_BUTTON in
	1) dunstify "$(curl -s wttr.in/Calgary?T1 | head -17)"
esac

case $WCODE in
    2*)     ICON="󰖓" ;; # Thunderstorm
    3*)     ICON="󰖗" ;; # Drizzle
    5*)     ICON="󰖖" ;; # Rain
    6*)     ICON="󰖘" ;; # Snow
    7*)     ICON="󰖑" ;; # Atmosphere
    800)    ICON="󰖙" ;; # Clear
    80[12]) ICON="󰖕" ;; # Cloudy
    80[34]) ICON="󰖐" ;; # Overcast
esac

echo -e "${ICON}  ${CURRTEMP}C"
