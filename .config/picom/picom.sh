#!/usr/bin/bash

killall picom
picom --config ~/.config/picom/picom.conf &
#picom --config ~/.config/picom/picom.conf --glx-fshader-win "$(cat ~/.config/picom/darkmode.glsl)" &
