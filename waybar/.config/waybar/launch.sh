#!/bin/bash

# Kill existing Waybar instances
pkill waybar

# Give a little delay to ensure it's fully terminated
sleep 0.5

# Launch Waybar
waybar & disown
