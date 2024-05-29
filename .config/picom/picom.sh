#!/usr/bin/env fish

killall picom
picom --config ~/.config/picom/picom.conf --window-shader-fg ~/.config/picom/darkmode.glsl &
