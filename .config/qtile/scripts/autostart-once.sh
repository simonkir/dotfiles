#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}



#start sxhkd to replace Qtile native key-bindings
sxhkd -c ~/.config/sxhkd/sxhkdrc &

# starting utility applications at boot time
# run variety &
run volumeicon &
run nm-applet &
# blueberry-tray &

~/.config/picom/picom.sh &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
run xfce4-power-manager &

#starting user applications at boot time
nitrogen --restore &
~/.emacs.d/launch-daemon.sh &
