#!/bin/bash
set -e

# === Paths ===
CURRENT_WALLPAPER=$(readlink -f "$HOME/.config/omarchy/current/background")
# MATUGEN="$HOME/.cargo/bin/matugen"
MATUGEN="$(command -v matugen)"
MATUGEN_CONFIG="$HOME/.config/matugen/config.toml"

# === 1. Generate new color palette ===
# (no preview, just update colors)
$MATUGEN --config "$MATUGEN_CONFIG" image "$CURRENT_WALLPAPER" -m "dark"

# === 2. Update Waybar, SwayOSD, and Dunst ===
omarchy-restart-waybar
omarchy-restart-swayosd

# Restart Dunst cleanly
if pgrep -x dunst >/dev/null; then
  pkill dunst
  sleep 0.2
fi
setsid dunst >/dev/null 2>&1 &

# === 3. Update Hyprland colors (no reload) ===
# Optional: If Matugen exports a Hyprland colors file, re-source it dynamically
# Example assumes Matugen writes ~/.cache/matugen/hyprland.conf
HYPR_COLOR_FILE="$HOME/.cache/matugen/hyprland.conf"
if [[ -f "$HYPR_COLOR_FILE" ]]; then
  while IFS= read -r line; do
    [[ -z "$line" || "$line" == \#* ]] && continue
    hyprctl keyword "$line" >/dev/null 2>&1 || true
  done <"$HYPR_COLOR_FILE"
fi

# === 4. Reload other apps that need it ===
# Uncomment if necessary:
# kvantummanager --set Matugen

# Refresh Kitty color scheme without closing it
if pgrep -x kitty >/dev/null; then
  pkill -SIGUSR1 kitty
fi
