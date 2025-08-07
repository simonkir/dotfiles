#!/usr/bin/env fish

# restore default screenlayout
#
# note: currently, no live updating supported
#       to update, run this script and restart wm

set -l screencount (xrandr --prop | grep " connected" | wc -l)

if test $screencount = 2
    xrandr --output eDP-1 --auto --output HDMI-1 --primary --auto --right-of eDP-1
else if test $screencount = 1
    xrandr --output eDP-1 --primary --auto --output HDMI-1 --off
end
