#!/bin/bash

sxhkd -c ~/.config/sxhkd/sxhkdrc &

volumeicon &
nm-applet &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
xfce4-power-manager &

~/.config/picom/picom.sh &
~/.emacs.d/launch-daemon.sh &
~/.config/simonkir/random-wallpaper.sh &
~/.config/conky/launch-conky.sh &
