#!/usr/bin/env sh

# Launch polybar
if type "xrandr"; then # multiple monitors

    # launch polybar on both monitors
    MONITOR=HDMI1 polybar -r main &
    MONITOR=eDP1  polybar -r main &

else # only one monitor
    polybar -r main &
fi
