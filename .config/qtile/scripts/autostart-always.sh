#!/usr/bin/env fish

~/.config/simonkir/screenlayout.sh
~/.config/simonkir/random-wallpaper.sh &
~/.config/conky/launch-conky.sh &

# keymap resets after system changes (e. g. system upgrades, xrandr changes)
setxkbmap -option caps:escape &

# when using laptop w/o external monitor, numpad should be off
# in order to to access <end>, <home> etc. keys
if test (xrandr --prop | grep " connected" | wc -l) = 2
    numlockx on &
else
    numlockx off &
end
