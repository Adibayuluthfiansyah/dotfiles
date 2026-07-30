#!/bin/bash

# Command to run nwg-dock-hyprland
# DOCK_CMD="nwg-dock-hyprland -i 25 -w 5 -mb 5 -x -s style.css -c 'walker'"

DOCK_CMD="nwg-dock-hyprland -i 25 -w 5 -mb 10 -x -s style.css -c 'rofi -show drun'"

# Check if nwg-dock-hyprland is running using full command match
if pgrep -f "nwg-dock-hyprland" >/dev/null; then
  echo "Dock is running, stopping it..."
  pkill -f "nwg-dock-hyprland"
else
  echo "Dock is not running, starting it..."
  # Run in background and detach from terminal
  nohup bash -c "$DOCK_CMD" >/dev/null 2>&1 &
fi
