#!/usr/bin/env fish

# kill redundant running betterlockscreen conversion processes
# important when calling the script multiple times in a row
for pid in (ps -ef | grep "betterlockscreen" | awk '{print $2}')
    kill -9 $pid
end

# for easier file paths futther down
cd $HOME/.config/simonkir/backgrounds

set -l screencount (xrandr --prop | grep " connected" | wc -l)
set -l pics (ls | sort -R | tail -$screencount)

echo $pics
feh --bg-fill $pics &
betterlockscreen -u $pics[1] &
