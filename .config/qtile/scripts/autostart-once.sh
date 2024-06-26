#!/usr/bin/env fish

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
xfce4-power-manager &

emacs --daemon &
sxhkd -c ~/.config/sxhkd/sxhkdrc &

~/.config/picom/picom.sh &

volumeicon &
nm-applet &

if not bluetoothctl show | grep -q "No default controller available"
    blueberry-tray &
end
