#!/bin/bash

killall conky
conky --config=$HOME/.config/conky/clock.conkyrc &
