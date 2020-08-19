#!/bin/bash
# baraction.sh for spectrwm status bar

## RAM
mem() {
  mem=`free | awk '/Mem/ {printf "%dM/%dM\n", $3 / 1024.0, $2 / 1024.0 }'`
  echo -e "$mem"
}

## CPU
cpu() {
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo -e "CPU: $cpu%"
}

## BATTERY
battery() {
    battery=`upower -i $(upower -e | grep '/battery') | grep --color=never -E percentage|xargs|cut -d' ' -f2|sed s/%//`
    echo -e "$battery"
}

## TIME
systime() {
    systime=`date +'%H:%M'`
    echo -e "$systime"
}

## PACMAN UPDATES
pacup() {
    pacup=`checkupdatescheckupdates | wc -l`
    echo -e "$pacup"
}

SLEEP_SEC=10
#loops forever outputting a line every SLEEP_SEC secs

# It seems that we are limited to how many characters can be displayed via
# the baraction script output. And the the markup tags count in that limit.
# So I would love to add more functions to this script but it makes the 
# echo output too long to display correctly.
while :; do
    echo "+@fg=4; +@fn=0; UPDATES: $(pacup) +@fg=0; | +@fg=1; +@fn=0; $(cpu) +@fg=0; | +@fg=5; +@fn=0; RAM: $(mem) +@fg=0; |+@fg=3; +@fn=0; BAT: $(battery) % +@fg=0; | +@fg=2; $(systime) +@fg=0;"
	sleep $SLEEP_SEC
done
