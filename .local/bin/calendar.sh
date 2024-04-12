#!/bin/bash

case $BLOCK_BUTTON in
    1) ACTION=curr;;
    4) ACTION=next;;
    5) ACTION=prev;;
esac

send_notification() {
	TODAY=$(date '+%-d')
	HEAD=$(cal "$1" | head -n1)
	BODY=$(cal "$1" | tail -n7 | sed -z "s|$TODAY|<u><b>$TODAY</b></u>|1")
	FOOT="\n<i>       ~ calendar</i> 󰸗 "
	dunstify -h string:x-canonical-private-synchronous:calendar \
		"$HEAD" "$BODY$FOOT" -u info -i '\n'
}

handle_action() {
	echo "$DIFF" > "$TMP"
	if [ "$DIFF" -ge 0 ]; then
		send_notification "+$DIFF months"
	else
		send_notification "$((-DIFF)) months ago"
	fi
}

TMP=${XDG_RUNTIME_DIR:-/tmp}/"$UID"_calendar_notification_month
touch "$TMP"

DIFF=$(<"$TMP")

case $ACTION in
	"curr") DIFF=0;;
	"next") DIFF=$((DIFF+1));;
	"prev") DIFF=$((DIFF-1));;
esac

date "+%a %b %d %H:%M"

[[ -z ${BLOCK_BUTTON+x} ]] || handle_action
