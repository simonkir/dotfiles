#!/usr/bin/bash

while emacs --fg-daemon "$@"; [[ $? -ne 123 ]]; do :; done
