#!/bin/bash

# Get the ID of the current active workspace.
CURRENT_WORKSPACE=$(hyprctl activeworkspace -j | jq -r '.id')

# Get the address of all windows on the current workspace.
WINDOW_ADDRESSES=$(hyprctl clients -j | jq -r --arg ws "$CURRENT_WORKSPACE" '.[] | select(.workspace.id == ($ws | tonumber)) | .address')

# Check if there are any windows to move.
if [ -z "$WINDOW_ADDRESSES" ]; then
  exit 0
fi

# Get the target workspace from the script's first argument ($1).
TARGET_WORKSPACE=$1

# Loop through each window address and move it.
for ADDRESS in $WINDOW_ADDRESSES; do
  # Correct syntax to move a specific window by its address.
  hyprctl dispatch movetoworkspace "$TARGET_WORKSPACE,address:$ADDRESS"
done

# After moving all windows, switch to the target workspace
# to complete the "move and follow" action.
hyprctl dispatch workspace "$TARGET_WORKSPACE"

exit 0
