#!/bin/bash

# Check if Waybar is running
if pgrep -x "waybar" > /dev/null; then
    # If running, kill it
    pkill waybar
else
    # If not running, launch it
    ~/.config/waybar/launch.sh
fi
