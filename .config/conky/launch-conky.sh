#!/bin/bash

killall conky
conky --config=$HOME/.config/conky/clock.conkyrc &
conky --config=$HOME/.config/conky/clock.conkyrc -x -1900 &
