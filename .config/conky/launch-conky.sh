#!/usr/bin/env fish

set -l screencount (xrandr --prop | grep " connected" | wc -l)

killall conky

if test $screencount = 2
    # screen 1 -- primary
    conky --xinerama-head=0 --config=$HOME/.config/conky/clock.conkyrc --alignment tm -y 100 &
    conky --xinerama-head=0 --config=$HOME/.config/conky/quotes.conkyrc --alignment bm -y 95 &

    # screen 2 -- secondary
    conky --xinerama-head=1 --config=$HOME/.config/conky/clock.conkyrc --alignment tl -x 100 &
    conky --xinerama-head=1 --config=$HOME/.config/conky/quotes.conkyrc --alignment bl -y 70 -x 50 &

else if test $screencount = 1
    conky --config=$HOME/.config/conky/clock.conkyrc --alignment tm -y 85 &
    conky --config=$HOME/.config/conky/quotes.conkyrc --alignment bm -y 85 &
end
