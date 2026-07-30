#!/usr/bin/env bash

# Config file priority (order matters)
CONFIG_FILES=(
    "$HOME/.config/hypr/conf/environment.conf"
    "$HOME/.config/hypr/hyprland.conf"
)

# Themes
# DARK_THEME="Adwaita-dark"
# LIGHT_THEME="Adwaita"
DARK_THEME="Graphite-Dark"
LIGHT_THEME="Graphite-Light"


# Debug file
DEBUG_LOG="/tmp/hypr-theme-debug.log"
echo "=== Theme Toggle Debug ===" > "$DEBUG_LOG"

# 1. Find which config file has the active GTK_THEME setting
ACTIVE_CONFIG=""
for config in "${CONFIG_FILES[@]}"; do
    if [ -f "$config" ]; then
        echo "Checking $config" >> "$DEBUG_LOG"
        GTK_LINE=$(grep "GTK_THEME" "$config" | grep -v '^#')
        if [ -n "$GTK_LINE" ]; then
            ACTIVE_CONFIG="$config"
            echo "Found active config: $ACTIVE_CONFIG" >> "$DEBUG_LOG"
            echo "Line content: $GTK_LINE" >> "$DEBUG_LOG"
            break
        fi
    fi
done

# Fallback to main config if not found
ACTIVE_CONFIG="${ACTIVE_CONFIG:-$HOME/.config/hypr/hyprland.conf}"
echo "Using config file: $ACTIVE_CONFIG" >> "$DEBUG_LOG"

# 2. Get current theme (three methods)
# Method 1: From existing environment
CURRENT_THEME="$GTK_THEME"
[ -z "$CURRENT_THEME" ] && echo "GTK_THEME not set in environment" >> "$DEBUG_LOG"

# Method 2: From active config file
if [ -z "$CURRENT_THEME" ]; then
    GTK_LINE=$(grep "GTK_THEME" "$ACTIVE_CONFIG" | grep -v '^#')
    CURRENT_THEME=$(echo "$GTK_LINE" | sed -E 's/.*GTK_THEME[=,]([^, ]*).*/\1/')
    [ -z "$CURRENT_THEME" ] && echo "Could not parse theme from config" >> "$DEBUG_LOG"
fi

# Method 3: From gsettings
if [ -z "$CURRENT_THEME" ]; then
    CURRENT_THEME=$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'")
    echo "Falling back to gsettings: $CURRENT_THEME" >> "$DEBUG_LOG"
fi

# Final fallback
CURRENT_THEME="${CURRENT_THEME:-$DARK_THEME}"
echo "Determined current theme: $CURRENT_THEME" >> "$DEBUG_LOG"
echo "DEBUG: CURRENT_THEME='$CURRENT_THEME'" >> "$DEBUG_LOG"


# 3. Determine new theme
if [[ "${CURRENT_THEME,,}" == *"dark"* ]]; then
    NEW_THEME="$LIGHT_THEME"
    MODE="Light"
else
    NEW_THEME="$DARK_THEME"
    MODE="Dark"
fi
echo "Setting new theme: $NEW_THEME ($MODE)" >> "$DEBUG_LOG"

# 4. Update ALL config files (to maintain consistency)
for config in "${CONFIG_FILES[@]}"; do
    if [ -f "$config" ]; then
        echo "Updating $config" >> "$DEBUG_LOG"
        # Handle both formats: "env = GTK_THEME,value" and "GTK_THEME=value"
        sed -i.bak -E \
            -e "s/^(#\s*)?(env\s*=\s*GTK_THEME,).*/\2$NEW_THEME/" \
            -e "s/^(#\s*)?(GTK_THEME=).*/\2$NEW_THEME/" \
            "$config"
        echo "New content:" >> "$DEBUG_LOG"
        grep "GTK_THEME" "$config" >> "$DEBUG_LOG"
    fi
done

# NEW: Update GTK settings.ini files
GTK_CONFIG_DIRS=(
    "$HOME/.config/gtk-3.0"
    "$HOME/.config/gtk-4.0"
)

for dir in "${GTK_CONFIG_DIRS[@]}"; do
    settings_file="$dir/settings.ini"
    if [ -f "$settings_file" ]; then
        echo "Updating $settings_file" >> "$DEBUG_LOG"
        sed -i.bak -E "s/^(gtk-theme-name=).*/\1$NEW_THEME/" "$settings_file"
        echo "New content:" >> "$DEBUG_LOG"
        grep "gtk-theme-name" "$settings_file" >> "$DEBUG_LOG"
    else
        # Create the file if it doesn't exist
        mkdir -p "$dir"
        echo "[Settings]" > "$settings_file"
        echo "gtk-theme-name=$NEW_THEME" >> "$settings_file"
        echo "Created new $settings_file" >> "$DEBUG_LOG"
    fi
done

# 5. Update system settings
export GTK_THEME="$NEW_THEME"
gsettings set org.gnome.desktop.interface gtk-theme "$NEW_THEME"
if [[ "${NEW_THEME,,}" == *"dark"* ]]; then
    gsettings set org.gnome.desktop.interface gtk-theme "$NEW_THEME"
    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
else
    gsettings set org.gnome.desktop.interface gtk-theme "$NEW_THEME"
    gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
fi


# 6. Notify and reload
notify-send -t 3000 "GTK Theme Toggled" "Switched to $MODE mode ($NEW_THEME)"
hyprctl reload

echo "=== Toggle Complete ===" >> "$DEBUG_LOG"
