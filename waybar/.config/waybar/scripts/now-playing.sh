#  /$$   /$$                               /$$$$$$$  /$$                     /$$
# | $$$ | $$                              | $$__  $$| $$                    |__/
# | $$$$| $$  /$$$$$$  /$$  /$$  /$$      | $$  \ $$| $$  /$$$$$$  /$$   /$$ /$$ /$$$$$$$   /$$$$$$
# | $$ $$ $$ /$$__  $$| $$ | $$ | $$      | $$$$$$$/| $$ |____  $$| $$  | $$| $$| $$__  $$ /$$__  $$
# | $$  $$$$| $$  \ $$| $$ | $$ | $$      | $$____/ | $$  /$$$$$$$| $$  | $$| $$| $$  \ $$| $$  \ $$
# | $$\  $$$| $$  | $$| $$ | $$ | $$      | $$      | $$ /$$__  $$| $$  | $$| $$| $$  | $$| $$  | $$
# | $$ \  $$|  $$$$$$/|  $$$$$/$$$$/      | $$      | $$|  $$$$$$$|  $$$$$$$| $$| $$  | $$|  $$$$$$$
# |__/  \__/ \______/  \_____/\___/       |__/      |__/ \_______/ \____  $$|__/|__/  |__/ \____  $$
#                                                                  /$$  | $$               /$$  \ $$
#                                                                 |  $$$$$$/              |  $$$$$$/
#                                                                  \______/                \______/
#___________________________________________________________________________________________________
# By Affan Mustafa 2025
#___________________________________________________________________________________________________

#!/bin/bash

VISIBLE_MIN=10
SCROLL_FILE="$HOME/.cache/nowplaying_scroll_pos"
MEDIA_FILE="$HOME/.cache/nowplaying_last_track"

player_status=$(playerctl status 2>/dev/null)
if [[ $? -ne 0 || -z "$player_status" ]]; then
    rm -f "$SCROLL_FILE" "$MEDIA_FILE"
    exit 0
fi

artist=$(playerctl metadata xesam:artist 2>/dev/null)
title=$(playerctl metadata xesam:title 2>/dev/null)

if [[ -z "$artist" && -z "$title" ]]; then
    exit 0
fi

track="$title • $artist • "

last_track=$(cat "$MEDIA_FILE" 2>/dev/null)
if [[ "$track" != "$last_track" ]]; then
    echo "$track" > "$MEDIA_FILE"
    echo "0" > "$SCROLL_FILE"
    scroll_pos=0
else
    scroll_pos=$(cat "$SCROLL_FILE" 2>/dev/null)
    [[ -z "$scroll_pos" ]] && scroll_pos=0
fi

visible_chars=$(( ${#track} * 1 / 2 ))
[[ $visible_chars -lt $VISIBLE_MIN ]] && visible_chars=$VISIBLE_MIN
[[ $visible_chars -gt 30 ]] && visible_chars=30

if [[ "$player_status" == "Paused" ]]; then
    :
else
    scroll_pos=$((scroll_pos + 1))

    if (( scroll_pos > ${#track} )); then
        sleep 2
        scroll_pos=0
    fi

    echo "$scroll_pos" > "$SCROLL_FILE"
fi

# Create scrolling text
if (( scroll_pos + visible_chars <= ${#track} )); then
    display_text="${track:scroll_pos:visible_chars}"
else
    wrap_len=$(( scroll_pos + visible_chars - ${#track} ))
    display_text="${track:scroll_pos}${track:0:wrap_len}"
fi

# Output JSON for Waybar
echo "{\"text\": \"$display_text\", \"class\": \"${player_status,,}\"}"
