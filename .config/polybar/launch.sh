#!/usr/bin/env sh

# Launch polybar
if type "xrandr"; then # multiple monitors

    # launch polybar on both monitors
    MONITOR=HDMI1 polybar -r main-incl-tray &
    MONITOR=eDP1  polybar -r main-no-tray &

else # only one monitor
    polybar -r main-incl-tray &
fi
