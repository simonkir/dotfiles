#!/usr/bin/env sh

# Launch polybar
if type "xrandr"; then # multiple monitors

    # launch polybar on every connected monitor
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar -r main &
    done

else # only one monitor
    polybar -r main &
fi
