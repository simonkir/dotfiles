#!/bin/bash

killall conky
conky --config=$HOME/.config/conky/clock.conkyrc --alignment tr -x 80 &
conky --config=$HOME/.config/conky/clock.conkyrc --alignment tl -x -1840 &
conky --config=$HOME/.config/conky/quotes.conkyrc --alignment bl -x 40 &
