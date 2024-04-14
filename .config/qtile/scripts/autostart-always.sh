#!/usr/bin/env fish

setxkbmap -option caps:escape &

# when using laptop w/o external monitor, numpad should be off
# in order to to access <end>, <home> etc. keys
if test (xrandr --prop | grep " connected" | wc -l) = 2
    numlockx on &
else
    numlockx off &
end
