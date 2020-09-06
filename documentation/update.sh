# add execute permission to scripts
chmod +x ~/.i3/create_config
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/polybar/scripts/tempcores.sh
chmod +x ~/.config/vifm/scripts/vifmimg
chmod +x ~/.config/vifm/scripts/vifmrun
chmod +x ~/.config/spectrwm/scripts/bar.sh
chmod +x ~/.config/herbstluftwm/scripts/picom-launch.sh

# hlwm config permissions
chmod +x ~/.config/herbstluftwm/autostart
chmod +x ~/.config/herbstluftwm/autostart.d/keybinds
chmod +x ~/.config/herbstluftwm/autostart.d/rules
chmod +x ~/.config/herbstluftwm/autostart.d/autostart
chmod +x ~/.config/herbstluftwm/autostart.d/attributes
chmod +x ~/.config/herbstluftwm/autostart.d/monitor-settings

# compile i3 config
~/.i3/create_config

chmod +x ~/.screenlayout/default.sh
