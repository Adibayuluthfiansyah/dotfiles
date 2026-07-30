#!/bin/bash

# Simple network speed monitor

# Get the default interface
INTERFACE=$(ip route | awk '/default/ {print $5}' | head -n 1)

# Check if interface exists
if [ -z "$INTERFACE" ]; then
  echo "No default interface found"
  exit 1
fi

# Get initial bytes
RX1=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
TX1=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)

sleep 1

# Get bytes after 1 second
RX2=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
TX2=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)

# Calculate speed
DRX=$((RX2 - RX1))
DTX=$((TX2 - TX1))

# Formatting function
format_speed() {
    local speed=$1
    if [ $speed -gt 1048576 ]; then
        echo "$speed" | awk '{printf "%.2f MB/s", $1 / 1048576}'
    elif [ $speed -gt 1024 ]; then
        echo "$speed" | awk '{printf "%.2f KB/s", $1 / 1024}'
    else
        echo "$speed B/s"
    fi
}

# Output for Waybar
echo -e "<span color='#FF5555'>↑</span> $(format_speed $DTX)  <span color='#50FA7B'>↓</span> $(format_speed $DRX)"