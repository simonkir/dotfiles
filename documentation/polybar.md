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

* If one monitor is connected, launch polybar on that one monitor.
* If more that one monitors are connected, launch polybar on two of them.

At the moment, there is no support for more than two monitors. The bar will be launched on `HDMI1` and `eDP1`.
