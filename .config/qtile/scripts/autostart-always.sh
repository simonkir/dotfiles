#!/usr/bin/env fish

~/.config/simonkir/screenlayout.sh
~/.config/simonkir/random-wallpaper.sh &
~/.config/conky/launch-conky.sh &

# keymap resets after system changes (e. g. system upgrades, xrandr changes)
setxkbmap -option caps:escape &
numlockx on &
