#!/usr/bin/bash



paired_devices=$(bluetoothctl devices Paired | grep Device | awk '{print $2}')

for device in $paired_devices; do
    echo $device
    bluetoothctl connect $device &
done
