#!/bin/bash

INTERFACE=$(ip route | awk '/default/ {print $5}' | head -n 1)

if [ -z "$INTERFACE" ]; then
    echo '{"text": "offline", "tooltip": "No default route"}'
    exit 0
fi

RX1=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
TX1=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)

sleep 1

RX2=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
TX2=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)

DRX=$((RX2 - RX1))
DTX=$((TX2 - TX1))

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

UP=$(format_speed $DTX)
DOWN=$(format_speed $DRX)
echo "{\"text\": \"↑ $UP  ↓ $DOWN\", \"tooltip\": \"$INTERFACE — up $UP / down $DOWN\"}"
