#!/usr/bin/bash



connected_devices=$(bluetoothctl devices Connected | grep Device | awk '{print $2}')

for device in $connected_devices; do
    echo $device
    bluetoothctl disconnect $device &
done
