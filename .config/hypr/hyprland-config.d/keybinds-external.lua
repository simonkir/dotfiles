-- * alphanumeric keys
hl.bind("SUPER + 9", hl.dsp.exec_cmd("hyprlock & sleep 1; systemctl suspend"))
hl.bind("SUPER + SHIFT + 9", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + CTRL + 9", hl.dsp.exec_cmd("hyprlock & sleep 1; systemctl hybrid-sleep"))

hl.bind("SUPER + ALT + A", hl.dsp.exec_cmd("emacsclient -cq --eval \"(sk:org-agenda-dashboard)\""))
hl.bind("SUPER + ALT + B", hl.dsp.exec_cmd("~/.config/simonkir/bluetooth-connect.sh"))
hl.bind("SUPER + ALT + SHIFT + B", hl.dsp.exec_cmd("~/.config/simonkir/bluetooth-disconnect.sh"))
hl.bind("SUPER + ALT + CTRL + B", hl.dsp.exec_cmd("blueman-manager"))
hl.bind("SUPER + ALT + C", hl.dsp.exec_cmd("thunderbird -calendar"))
hl.bind("SUPER + ALT + CTRL + C", hl.dsp.exec_cmd("thunderbird -addressbook"))
hl.bind("SUPER + ALT + D", hl.dsp.exec_cmd("digikam"))
hl.bind("SUPER + ALT + E", hl.dsp.exec_cmd("emacsclient -cq"))
hl.bind("SUPER + ALT + SHIFT + E", hl.dsp.exec_cmd("emacs"))
hl.bind("SUPER + ALT + F", hl.dsp.exec_cmd("~/.config/simonkir/nextcloud-files.sh"))
hl.bind("SUPER + ALT + I", hl.dsp.exec_cmd("inkscape"))
hl.bind("SUPER + ALT + J", hl.dsp.exec_cmd("firefox https://web.whatsapp.com"))
hl.bind("SUPER + ALT + K", hl.dsp.exec_cmd("krita"))
hl.bind("SUPER + ALT + M", hl.dsp.exec_cmd("thunderbird -mail"))
hl.bind("SUPER + ALT + SHIFT + M", hl.dsp.exec_cmd("emacsclient -cq --eval \"(sk:osm-home)\""))
hl.bind("SUPER + ALT + N", hl.dsp.exec_cmd("~/.config/simonkir/nextcloud-notes.sh"))
hl.bind("SUPER + ALT + O", hl.dsp.exec_cmd("libreoffice"))
hl.bind("SUPER + ALT + P", hl.dsp.exec_cmd("emacsclient -cq --eval \"(sk:run-ipython)\""))
hl.bind("SUPER + ALT + R", hl.dsp.exec_cmd("hyprlauncher"))
hl.bind("SUPER + ALT + S", hl.dsp.exec_cmd("spotify-launcher"))
hl.bind("SUPER + ALT + V", hl.dsp.exec_cmd("pavucontrol"))
hl.bind("SUPER + ALT + W", hl.dsp.exec_cmd("firefox"))
hl.bind("SUPER + ALT + X", hl.dsp.exec_cmd("killall hyprpaper; hyprpaper"))
hl.bind("SUPER + ALT + SHIFT + X", hl.dsp.exec_cmd("~/.config/conky/launch-conky.sh"))

-- * special keys
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("alacritty"))
hl.bind("SUPER + KP_ENTER", hl.dsp.exec_cmd("alacritty"))

hl.bind("Print", hl.dsp.exec_cmd("grim - | satty -f - --copy-command wl-copy"))

-- * multimedia keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

