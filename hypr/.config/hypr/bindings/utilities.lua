-- utilities.lua ← bindings/utilities.conf (29 active binds)
-- Shell substitutions ($()), pipes and && / || chains preserved verbatim.

-- Menus
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("omarchy-launch-walker"), { description = "Launch apps" })
hl.bind("SUPER + PERIOD", hl.dsp.exec_cmd("omarchy-launch-walker -m symbols"), { description = "Emoji picker" })
hl.bind("SUPER + ALT + SPACE", hl.dsp.exec_cmd("omarchy-menu"), { description = "Omarchy menu" })
hl.bind("SUPER + ESCAPE", hl.dsp.exec_cmd("omarchy-menu system"), { description = "System menu" })
hl.bind("XF86PowerOff", hl.dsp.exec_cmd("omarchy-menu system"), { description = "Power menu", locked = true })
hl.bind("SUPER + K", hl.dsp.exec_cmd("omarchy-menu-keybindings"), { description = "Show key bindings" })
hl.bind("XF86Calculator", hl.dsp.exec_cmd("gnome-calculator"), { description = "Calculator" })

-- Aesthetics
hl.bind("SUPER + SHIFT + SPACE", hl.dsp.exec_cmd("omarchy-toggle-waybar"), { description = "Toggle top bar" })
hl.bind("SUPER + CTRL + SPACE", hl.dsp.exec_cmd("omarchy-theme-bg-next"), { description = "Next background in theme" })
hl.bind("SUPER + SHIFT + CTRL + SPACE", hl.dsp.exec_cmd("omarchy-menu theme"), { description = "Theme menu" })
hl.bind("SUPER + BACKSPACE", hl.dsp.exec_cmd('hyprctl dispatch setprop "address:$(hyprctl activewindow -j | jq -r \'.address\')" opaque toggle'), { description = "Toggle window transparency" })
hl.bind("SUPER + SHIFT + BACKSPACE", hl.dsp.exec_cmd("omarchy-hyprland-workspace-toggle-gaps"), { description = "Toggle workspace gaps" })

-- Notifications
hl.bind("SUPER + COMMA", hl.dsp.exec_cmd("makoctl dismiss"), { description = "Dismiss last notification" })
hl.bind("SUPER + SHIFT + COMMA", hl.dsp.exec_cmd("makoctl dismiss --all"), { description = "Dismiss all notifications" })
hl.bind("SUPER + CTRL + COMMA", hl.dsp.exec_cmd("makoctl mode -t do-not-disturb && makoctl mode | grep -q 'do-not-disturb' && notify-send \"Silenced notifications\" || notify-send \"Enabled notifications\""), { description = "Toggle silencing notifications" })
hl.bind("SUPER + ALT + COMMA", hl.dsp.exec_cmd("makoctl invoke"), { description = "Invoke last notification" })

-- Toggle idling
hl.bind("SUPER + CTRL + I", hl.dsp.exec_cmd("omarchy-toggle-idle"), { description = "Toggle locking on idle" })

-- Toggle nightlight
hl.bind("SUPER + CTRL + N", hl.dsp.exec_cmd("omarchy-toggle-nightlight"), { description = "Toggle nightlight" })

-- Control Apple Display brightness
hl.bind("CTRL + F1", hl.dsp.exec_cmd("omarchy-cmd-apple-display-brightness -5000"), { description = "Apple Display brightness down" })
hl.bind("CTRL + F2", hl.dsp.exec_cmd("omarchy-cmd-apple-display-brightness +5000"), { description = "Apple Display brightness up" })
hl.bind("SHIFT + CTRL + F2", hl.dsp.exec_cmd("omarchy-cmd-apple-display-brightness +60000"), { description = "Apple Display full brightness" })

-- Captures
hl.bind("PRINT", hl.dsp.exec_cmd("omarchy-capture-screenshot"), { description = "Screenshot" })
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("omarchy-cmd-screenshot smart clipboard"), { description = "Screenshot to clipboard" })
hl.bind("ALT + PRINT", hl.dsp.exec_cmd("omarchy-menu screenrecord"), { description = "Screenrecording" })
hl.bind("SUPER + PRINT", hl.dsp.exec_cmd("pkill hyprpicker || hyprpicker -a"), { description = "Color picker" })

-- File sharing
hl.bind("SUPER + CTRL + S", hl.dsp.exec_cmd("omarchy-menu share"), { description = "Share" })

-- Waybar-less information
hl.bind("SUPER + CTRL + T", hl.dsp.exec_cmd('notify-send "    $(date +"%A %H:%M  —  %d %B W%V %Y")"'), { description = "Show time" })
hl.bind("SUPER + CTRL + X", hl.dsp.exec_cmd('notify-send "    Battery is at $(omarchy-battery-remaining)%"'), { description = "Show battery remaining" })

hl.bind("SUPER + W", hl.dsp.exec_cmd("omarchy-launch-wifi"), { description = "Share" })

hl.bind("SUPER + Z", hl.dsp.exec_cmd("blueberry"), { description = "Share" })
