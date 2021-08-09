#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}



numlockx on &
setxkbmap -option caps:escape &
