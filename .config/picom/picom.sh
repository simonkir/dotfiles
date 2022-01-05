#!/usr/bin/bash

picom --config ~/.config/picom/picom.conf --glx-fshader-win "$(cat ~/.config/picom/dark-mode.glsl)"
