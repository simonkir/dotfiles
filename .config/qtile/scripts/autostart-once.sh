#!/usr/bin/env fish

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
xfce4-power-manager &

~/.emacs.d/launch-daemon.sh &
sxhkd -c ~/.config/sxhkd/sxhkdrc &

~/.config/picom/picom.sh &
~/.config/simonkir/random-wallpaper.sh &
~/.config/conky/launch-conky.sh &

volumeicon &
nm-applet &

if not bluetoothctl show | grep -q "No default controller available"
    blueberry-tray &
end
