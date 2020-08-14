# Dependencies
* [`numlockx (community)`](https://www.archlinux.org/packages/community/x86_64/numlockx/) to enable the numlock on startup
* [`kupfer (community)`](https://www.archlinux.org/packages/community/any/kupfer/) to have a better application launcher
* `nitrogen` for the wallpaper. See 'Tips & Tricks' for more information!
* `setxkbmap` to remap caps lock to escape

# Note on Installing
* `~/.spectrwm.conf`: main config file
* `~/.config/spectrwm`: directory for scripts and other related stuff

# Tips & Tricks

## Bar
The default bar is replaced with `polybar`. See `documentation/polybar.md` for more information.

* `M-y` to toggle polybar
* `M-S-y` to toggle the default spectrwm bar

**Working Method:** The default spectrwm bar is shown but overlapped by polybar. Therefore, it creates the space that polybar needs without needing to manually resize screen sizes (which would be in conflict with the multi-monitor magaging described below).

## Screen Layouts
The config file automatically loads a script which takes care of the screen layouting and settings, located in `~/.screenlayout/default.sh`. All screen layout specific commands go into this file. If you don't have more than one screen, just don't create the mentioned file or leave it empty.

**Suggestion:** Use [`arandr (community)`](https://www.archlinux.org/packages/community/any/arandr/) to generate such a script.
