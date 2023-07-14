#!/bin/bash

connected_monitors=$(( $(xrandr --listactivemonitors | wc -l) - 1 ))
connected_monitors=1

killall conky

if [[ $connected_monitors == 2 ]]; then
    conky --config=$HOME/.config/conky/clock.conkyrc --alignment tr -x 80 &
    conky --config=$HOME/.config/conky/clock.conkyrc --alignment tl -x -1840 &
    conky --config=$HOME/.config/conky/quotes.conkyrc --alignment bl -x 40 &
    conky --config=$HOME/.config/conky/quotes.conkyrc --alignment bl -x -1880 &
elif [[ $connected_monitors == 1 ]]; then
    conky --config=$HOME/.config/conky/clock.conkyrc --alignment tl -x 40 &
    conky --config=$HOME/.config/conky/quotes.conkyrc --alignment bl -x 40 &
fi
