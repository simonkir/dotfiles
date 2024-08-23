#!/usr/bin/env fish

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
xfce4-power-manager &

emacs --daemon &
~/.config/sxhkd/launch-sxhkd.sh &
~/.config/picom/picom.sh &

nm-applet &
