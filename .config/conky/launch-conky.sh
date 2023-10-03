#!/bin/bash

connected_monitors=$(( $(xrandr --listactivemonitors | wc -l) - 1 ))

killall conky

if [[ $connected_monitors == 2 ]]; then
    # screen 1 -- primary
    conky --config=$HOME/.config/conky/clock.conkyrc --alignment tm -y 100 &
    conky --config=$HOME/.config/conky/quotes.conkyrc --alignment bm -y 75 &

    # screen 2 -- secondary
    conky --config=$HOME/.config/conky/clock.conkyrc --alignment tl -x -1820 &
    conky --config=$HOME/.config/conky/quotes.conkyrc --alignment bl -y 70 -x -1860 &

elif [[ $connected_monitors == 1 ]]; then
    # screen 1 -- primary
    conky --config=$HOME/.config/conky/clock.conkyrc --alignment tm -y 55 &
    conky --config=$HOME/.config/conky/quotes.conkyrc --alignment bm -y 70 &
fi
