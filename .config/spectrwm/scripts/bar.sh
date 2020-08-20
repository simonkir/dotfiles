#!/bin/bash
# baraction.sh for spectrwm status bar

## RAM
mem() {
  mem=`free | awk '/Mem/ {printf "%0.1fG/%0.1fG\n", $3 / 1024.0 / 1024.0, $2 / 1024.0 / 1024.0 }'`
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
  echo -e "$cpu%"
}

## BATTERY
battery() {
    battery=`upower -i $(upower -e | grep '/battery') | grep --color=never -E percentage|xargs|cut -d' ' -f2|sed s/%//`
    echo -e "$battery%"
}

## TIME
systime() {
    systime=`date +'%H:%M'`
    echo -e "$systime"
}

## PACMAN UPDATES
pacup() {
    pacup=`checkupdates | wc -l`
    echo -e "$pacup"
}

## MEAN CPU CORE TEMPERATURE
temp() {
    temp=`sensors | grep -m 1 Core | awk '{print substr($3, 2, length($3)-5)}'`
    echo -e "$temp °C"
}

SLEEP_SEC=10
#loops forever outputting a line every SLEEP_SEC secs

# It seems that we are limited to how many characters can be displayed via
# the baraction script output. And the the markup tags count in that limit.
# So I would love to add more functions to this script but it makes the 
# echo output too long to display correctly.
while :; do
    echo "+@fg=1; +@fn=1; +@fn=0; $(pacup) +@fg=0; | +@fg=0; +@fn=1;+@fn=0;  $(cpu) +@fg=0; | +@fg=5; +@fn=1; +@fn=0; $(mem) +@fg=0; | +@fg=2; +@fn=1; +@fn=0; $(battery) +@fg=0; | +@fg=4; +@fn=1; +@fn=0; $(temp) +@fg=0; | +@fg=3; +@fn=1; +@fn=0; $(systime)"
	sleep $SLEEP_SEC
done
