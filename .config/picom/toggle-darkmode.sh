#!/usr/bin/env fish

set -l window (xdotool getwindowfocus)
set -l invert (xprop -id $window 8c TAG_DARKMODE | cut -d " " -f 3)

if test $invert = 1
    set invert 0
else
    set invert 1
end

# toggle TAG_DARKMODE window attr
xprop -id $window -format TAG_DARKMODE 8c -set TAG_DARKMODE $invert
