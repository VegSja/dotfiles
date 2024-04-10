#!/bin/bash

# Check if Waybar is running
if pgrep -x "waybar" > /dev/null
then
    # If running, kill the process
    pkill waybar
    echo "Waybar has been stopped."
else
    # If not running, start the process
    waybar &
    echo "Waybar has been started."
fi
