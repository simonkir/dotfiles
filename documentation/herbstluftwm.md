herbstluftwm documentation

# Dependencies
* [`numlockx (community)`](https://www.archlinux.org/packages/community/x86_64/numlockx/)
* [`kupfer (community)`](https://www.archlinux.org/packages/community/any/kupfer/)
* `nitrogen`

# Usage
## config files
* `~/.config/herbstluftwm/autostart`: launched on hlwm startup
* `~/.config/herbstluftwm/autostart.d`: separate config files

## screen layouting
is taken care of by an external application such as `xrandr`. `~/.screenlayout/default.sh` will be executed on hlwm startup

*note about polybar:* 24px of screen space at the bottom is reserved (see `autostart.d/monitor-settings`)
