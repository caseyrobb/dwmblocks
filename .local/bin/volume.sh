#!/bin/bash

# Prints the current volume or 🔇 if muted.

. ~/.local/bin/nord.sh

case $BLOCK_BUTTON in
	1) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
	4) wpctl set-volume @DEFAULT_SINK@ 1%+ ;;
	5) wpctl set-volume @DEFAULT_SINK@ 1%- ;;
	3) notify-send "📢 Volume module" "\- Shows volume 🔊, 🔇 if muted.
- Click to mute.
- Scroll to change." ;;
	6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

vol="$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"

# If muted, print 🔇 and exit.
[ "$vol" != "${vol%\[MUTED\]}" ] && echo 🔇 && exit

vol="${vol#Volume: }"
split() {
	# For ommiting the . without calling and external program.
	IFS=$2
	set -- $1
	printf '%s' "$@"
}
vol="$(split "$vol" ".")"
vol="${vol##0}"

case 1 in
	$((vol >= 70)) ) icon="" ;;
	$((vol >= 30)) ) icon="" ;;
	$((vol >= 1)) ) icon="" ;;
	* ) echo 󰝟 && exit ;;
esac

#echo -e "${BGYELLOW}${FGBLACK} ${icon} ${vol}% ${FGGREEN}"
echo -e "${icon} ${vol}%"
