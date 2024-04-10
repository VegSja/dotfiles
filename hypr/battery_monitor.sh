#!/bin/bash

notify-send -u normal "Battery observer started" 
while true; do
    # Get battery percentage
    battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')

    # Check if battery level is below 20%
    if [ $battery_level -lt 20 ]; then
        notify-send -u critical "Battery Low" "Battery is below 20% ($battery_level%)"
    fi

    # Check if battery level is below 10%
    if [ $battery_level -lt 10 ]; then
        notify-send -u critical "Battery Very Low" "Battery is below 10% ($battery_level%)"
    fi

    # Sleep for 5 minutes before checking again
    sleep 300
done
