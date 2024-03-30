#!/usr/bin/env fish

set -l connected_devices (bluetoothctl devices Connected | grep Device | awk '{print $2}')

for device in $connected_devices
    bluetoothctl disconnect $device &
end
