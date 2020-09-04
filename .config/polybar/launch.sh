#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# wait for screenlayout script
sleep 1

# all monitors
outputs=$(xrandr --query | grep " connected" | cut -d" " -f1)

# monitor on which the tray will be shown,
# if HDMI1 is not connected
tray_output=eDP1

# if HDMI1 is connected, display tray in HDMI1
for m in $outputs; do
    if [[ $m == "HDMI1" ]]; then
        tray_output=$m
    fi
done

# launch bars
for m in $outputs; do
    export MONITOR=$m
    export TRAY_POSITION=none

    # include tray on bar
    # if monitor is HDMI1
    if [[ $m == $tray_output ]]; then
        TRAY_POSITION=right
    fi

    polybar --reload main &
    disown
done
