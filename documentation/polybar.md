# polybar

# Dependencies
* [polybar](https://aur.archlinux.org/packages/polybar)
* xrandr (for multi-monitor capabilities)

# Usage
The config directory is `~/.config/polybar/`

## Launching
Use the `launch.sh` script.

## Stopping
Use the `stop.sh` script.

# Tips and Tricks

## Multi-Monitor Capabilities
The `launch.sh` script by default looks at whether more than one monitor is connected.

The tray will be shown HDMI1 or on the monitor specified in `launch.sh`.

See [this comment](https://github.com/polybar/polybar/issues/763#issuecomment-450940924) on further explanation on this topic.
