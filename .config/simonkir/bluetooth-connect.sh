#!/usr/bin/env fish

set -l paired_devices (bluetoothctl devices Paired | grep Device | awk '{print $2}')

for device in $paired_devices
    bluetoothctl connect $device &
end
