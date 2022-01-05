#!/usr/bin/bash

window="$(xdotool getwindowfocus)"
status="$(xprop -id "$window" 8c TAG_DARKMODE | cut -d " " -f 3)"
[ "$status" != 1 ] && status=1 || status=0
xprop -id "$window" -format TAG_DARKMODE 8c -set TAG_DARKMODE "$status"
