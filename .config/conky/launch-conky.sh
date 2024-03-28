#!/bin/bash

connected_monitors=$(( $(xrandr --listactivemonitors | wc -l) - 1 ))

killall conky

if [[ $connected_monitors == 2 ]]; then
    # screen 1 -- primary
    conky --xinerama-head=0 --config=$HOME/.config/conky/clock.conkyrc --alignment tm -y 100 &
    conky --xinerama-head=0 --config=$HOME/.config/conky/quotes.conkyrc --alignment bm -y 95 &

    # screen 2 -- secondary
    conky --xinerama-head=1 --config=$HOME/.config/conky/clock.conkyrc --alignment tl -x 100 &
    conky --xinerama-head=1 --config=$HOME/.config/conky/quotes.conkyrc --alignment bl -y 70 -x 50 &

elif [[ $connected_monitors == 1 ]]; then
    # screen 1 -- primary
    conky --config=$HOME/.config/conky/clock.conkyrc --alignment tm -y 55 &
    conky --config=$HOME/.config/conky/quotes.conkyrc --alignment bm -y 70 &
fi
