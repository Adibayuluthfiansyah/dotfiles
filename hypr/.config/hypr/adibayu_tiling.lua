-- adibayu_tiling.lua ← adibayu_tiling.conf (full port, descriptions kept 1:1)
-- Source-verified mappings (Hyprland 0.56.x source + Omarchy 4 dev Lua):
--   movetoworkspacesilent → window.move({workspace=, follow=false})
--   changegroupactive b/f → group.prev()/group.next()
--   resizeactive Nx N → window.resize({x,y, relative=true})
--   moveactive Nx N   → window.move({x,y, relative=true})
--   submap winedit    → hl.submap() + hl.define_submap() block
-- ⚠️ KNOWN LOSS: `SUPER SHIFT, T, workspaceopt, allfloat` has NO Lua
--    equivalent (no such dsp in source) — left out, see note below.

-- # Close windows
hl.bind("SUPER + Q", hl.dsp.window.close(), { description = "Close active window" })
hl.bind("SUPER + END", hl.dsp.window.close(), { description = "Close active window" })
-- bindc = , mouse:274, killactive # Middle click on a window to close it
hl.bind("SUPER + CTRL + Q", hl.dsp.exec_cmd("hyprctl kill")) -- Forcefully zap a window
hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill")) -- Quit active window and all open instances
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd("omarchy-hyprland-window-close-all"), { description = "Close all Windows" })

-- # Control tiling
hl.bind("SUPER + J", hl.dsp.layout("togglesplit"), { description = "Toggle split" }) -- dwindle
hl.bind("SUPER + P", hl.dsp.window.pseudo(), { description = "Pseudo window" }) -- dwindle
hl.bind("SUPER + G", hl.dsp.group.toggle())
hl.bind("SUPER + bracketleft", hl.dsp.group.prev())
hl.bind("SUPER + bracketright", hl.dsp.group.next())
hl.bind("SUPER + O", hl.dsp.exec_cmd("omarchy-hyprland-window-pop"), { description = "Pop window out (float & pin)" })

-- Resize active window with SUPER CTRL
hl.bind("SUPER + CTRL + Apostrophe", hl.dsp.window.resize({ x = 100, y = 0, relative = true })) -- Increase window width with keyboard
hl.bind("SUPER + CTRL + Semicolon", hl.dsp.window.resize({ x = -100, y = 0, relative = true })) -- Reduce window width with keyboard
hl.bind("SUPER + CTRL + down", hl.dsp.window.resize({ x = 0, y = 100, relative = true })) -- Increase window height with keyboard
hl.bind("SUPER + CTRL + up", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))

-- special & hidden workspaces
hl.bind("SUPER + CTRL + B", hl.dsp.window.move({ workspace = "special:browser", follow = false })) -- Move to scratchpad
hl.bind("SUPER + SHIFT + B", hl.dsp.workspace.toggle_special("browser"))

hl.bind("SUPER + SHIFT + M", hl.dsp.workspace.toggle_special("music"))
hl.bind("SUPER + CTRL + M", hl.dsp.window.move({ workspace = "special:music", follow = false }))

hl.bind("SUPER + SHIFT + E", hl.dsp.workspace.toggle_special("file"))
hl.bind("SUPER + CTRL + E", hl.dsp.window.move({ workspace = "special:file", follow = false }))

hl.bind("SUPER + SHIFT + D", hl.dsp.workspace.toggle_special("down"))
hl.bind("SUPER + CTRL + Down", hl.dsp.workspace.toggle_special("down"))
hl.bind("SUPER + CTRL + D", hl.dsp.window.move({ workspace = "special:down", follow = false }))

hl.bind("SUPER + SHIFT + U", hl.dsp.workspace.toggle_special("up"))
hl.bind("SUPER + CTRL + Up", hl.dsp.workspace.toggle_special("up"))
hl.bind("SUPER + CTRL + U", hl.dsp.window.move({ workspace = "special:up", follow = false }))

hl.bind("SUPER + SHIFT + I", hl.dsp.workspace.toggle_special("instagram"))

hl.bind("SUPER + CTRL + W", hl.dsp.window.move({ workspace = "special:whatsapp", follow = false }))
hl.bind("SUPER + SHIFT + W", hl.dsp.workspace.toggle_special("whatsapp"))

hl.bind("SUPER + CTRL + V", hl.dsp.window.move({ workspace = "special:video", follow = false }))
hl.bind("SUPER + SHIFT + V", hl.dsp.workspace.toggle_special("video"))

hl.bind("SUPER + CTRL + K", hl.dsp.window.move({ workspace = "special:kitty", follow = false }))
hl.bind("SUPER + SHIFT + K", hl.dsp.workspace.toggle_special("kitty"))

hl.bind("SUPER + CTRL + C", hl.dsp.window.move({ workspace = "special:chatgpt", follow = false }))
hl.bind("SUPER + SHIFT + C", hl.dsp.workspace.toggle_special("chatgpt"))

hl.bind("SUPER + CTRL + A", hl.dsp.window.move({ workspace = "special:waydroid", follow = false }))
hl.bind("SUPER + SHIFT + A", hl.dsp.workspace.toggle_special("waydroid"))

hl.bind("SUPER + CTRL + O", hl.dsp.window.move({ workspace = "special:obsidian", follow = false }))
hl.bind("SUPER + SHIFT + O", hl.dsp.workspace.toggle_special("obsidian"))

-- bindd = SUPER, T, Toggle floating, togglefloating,
-- Toggle focused window between normal and 1280x720 centered
hl.bind("SUPER + T", hl.dsp.exec_cmd("hyprctl dispatch togglefloating && hyprctl dispatch resizeactive exact 1280 720 && hyprctl dispatch centerwindow"))

hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }), { description = "Full screen" })
hl.bind("SUPER + CTRL + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 2 }), { description = "Tiled full screen" })
-- bindd = SUPER SHIFT, F, Spoof Fullscreen, fullscreenstate, 0 3
hl.bind("SUPER + D", hl.dsp.window.fullscreen({ mode = "maximized" }), { description = "Maximize" })
-- ⚠️ NO LUA EQUIVALENT (verified: no such dispatcher in Hyprland source):
-- bind = SUPER SHIFT, T, workspaceopt, allfloat # Toggle all windows into floating mode

-- # Move focus with SUPER + arrow keys
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }), { description = "Move focus left" })
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }), { description = "Move focus right" })
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }), { description = "Move focus up" })
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }), { description = "Move focus down" })

hl.bind("SUPER + HOME", hl.dsp.focus({ workspace = "1" }))
-- Workspaces
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = "1" })) -- Open workspace 1
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = "2" })) -- Open workspace 2
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = "3" })) -- Open workspace 3
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = "4" })) -- Open workspace 4
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = "5" })) -- Open workspace 5
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = "6" })) -- Open workspace 6
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = "7" })) -- Open workspace 7
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = "8" })) -- Open workspace 8
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = "9" })) -- Open workspace 9
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = "10" })) -- Open workspace 10

hl.bind("SUPER + SHIFT + HOME", hl.dsp.window.move({ workspace = "1" }))
-- # Move active window to a workspace with SUPER + SHIFT + [0-9]
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = "1" })) -- Move active window to workspace 1
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = "2" })) -- Move active window to workspace 2
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = "3" })) -- Move active window to workspace 3
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = "4" })) -- Move active window to workspace 4
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = "5" })) -- Move active window to workspace 5
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = "6" })) -- Move active window to workspace 6
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = "7" })) -- Move active window to workspace 7
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = "8" })) -- Move active window to workspace 8
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = "9" })) -- Move active window to workspace 9
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = "10" })) -- Move active window to workspace 10

-- # Tab between workspaces
hl.bind("SUPER + TAB", hl.dsp.focus({ workspace = "e+1" }), { description = "Next workspace" })
hl.bind("SUPER + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }), { description = "Previous workspace" })

-- # Cycle through applications on active workspace
hl.bind("ALT + Tab", hl.dsp.window.cycle_next(), { description = "Cycle to next window" })
hl.bind("ALT + SHIFT + Tab", hl.dsp.window.cycle_next({ next = false }), { description = "Cycle to prev window" })
hl.bind("ALT + Tab", hl.dsp.window.bring_to_top(), { description = "Reveal active window on top" })
hl.bind("ALT + SHIFT + Tab", hl.dsp.window.bring_to_top(), { description = "Reveal active window on top" })

-- # Swap active window with the one next to it with SUPER + SHIFT + arrow keys
hl.bind("SUPER + ALT + left", hl.dsp.window.swap({ direction = "left" }), { description = "Swap window to the left" })
hl.bind("SUPER + ALT + right", hl.dsp.window.swap({ direction = "right" }), { description = "Swap window to the right" })
hl.bind("SUPER + ALT + up", hl.dsp.window.swap({ direction = "up" }), { description = "Swap window up" })
hl.bind("SUPER + ALT + down", hl.dsp.window.swap({ direction = "down" }), { description = "Swap window down" })

-- bind = Super+Alt, Left, movewindow, l # [hidden]
-- bind = Super+Alt, Right, movewindow, r # [hidden]
-- bind = Super+Alt, Up, movewindow, u # [hidden]
-- bind = Super+Alt, Down, movewindow, d # [hidden]

-- # Resize active window
-- binde = SUPER, Semicolon, splitratio, -0.1 # adjust split ratio
-- binde = SUPER, Apostrophe, splitratio, +0.1 # adjust split ratio
-- binde = SUPER, F1, splitratio, -0.1   # adjust split ratio
-- binde = SUPER, F2, splitratio, +0.1   # adjust split ratio

-- # Scroll through existing workspaces with SUPER + scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Scroll active workspace forward" })
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = "Scroll active workspace backward" })

-- # Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { description = "Move window", mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { description = "Resize window", mouse = true })

-- #/# bind = Super+Shift, Scroll ↑/↓,, # Send to workspace left/right
hl.bind("SUPER + SHIFT + mouse_down", hl.dsp.window.move({ workspace = "r-1" })) -- [hidden]
hl.bind("SUPER + SHIFT + mouse_up", hl.dsp.window.move({ workspace = "r+1" })) -- [hidden]

--#/# bind = Super+Shift, Page_↑/↓,, # Send to workspace left/right
hl.bind("SUPER + SHIFT + Page_Down", hl.dsp.window.move({ workspace = "r+1" })) -- [hidden]
hl.bind("SUPER + SHIFT + Page_Up", hl.dsp.window.move({ workspace = "r-1" })) -- [hidden]

--#/# move window to left/right workspaces
hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind("SUPER + SHIFT + left", hl.dsp.window.move({ workspace = "r-1" }))

--#/# bind = Ctrl+Super, ←/→,, # Focus left/right
hl.bind("CTRL + SUPER + Right", hl.dsp.focus({ workspace = "r+1" })) -- [hidden]
hl.bind("CTRL + SUPER + Left", hl.dsp.focus({ workspace = "r-1" })) -- [hidden]

--#/# bind = Super, Page_↑/↓,, # Focus left/right
hl.bind("SUPER + Page_Down", hl.dsp.focus({ workspace = "+1" })) -- [hidden]
hl.bind("SUPER + Page_Up", hl.dsp.focus({ workspace = "-1" })) -- [hidden]

--Toggle GTK Theme
-- bind = SUPER Alt, P, exec, ~/.config/hypr/scripts/toggle-gtk-theme.sh

-- Toggle dock
-- bind = SUPER Shift, D, exec, ~/.config/hypr/scripts/toggle-dock.sh
-- bind = SUPER+ctrl, D, exec, ~/.local/bin/toggle-dock.sh

-- brightness
-- bindle= CTRL ALT, right, exec, qs ipc call brightness increment || brightnessctl s 2%+ # [hidden]
-- bindle= CTRL ALT, left, exec, qs ipc call brightness decrement || brightnessctl s 2%- # [hidden]

-- waybar
-- bind = SUPER SHIFT, B, exec, ~/.config/waybar/launch.sh # Reload waybar
-- bind = SUPER CTRL, B, exec, ~/.config/waybar/toggle.sh  # Toggle waybar

-- Enter Window Edit Mode
hl.bind("SUPER + X", hl.dsp.submap("winedit"))

-- NOTE: binds inside define_submap belong to that submap (source-verified).
-- moveactive Nx N → window.move({x, y, relative=true}) (dsp_move = CA::move).
hl.define_submap("winedit", function()
    -- --- Move active window with arrow keys ---
    hl.bind("left", hl.dsp.window.move({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind("right", hl.dsp.window.move({ x = 10, y = 1, relative = true }), { repeating = true })
    hl.bind("up", hl.dsp.window.move({ x = 0, y = -10, relative = true }), { repeating = true })
    hl.bind("down", hl.dsp.window.move({ x = 0, y = 10, relative = true }), { repeating = true })

    -- --- Resize active window with SHIFT + arrows ---
    hl.bind("SHIFT + left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind("SHIFT + right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
    hl.bind("SHIFT + up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
    hl.bind("SHIFT + down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })

    -- Exit Window Edit Mode
    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind("return", hl.dsp.submap("reset"))
    -- Back to normal keybinds
end)

local HYPRSCRIPTS = "~/.config/hypr/scripts"

hl.bind("SUPER + CTRL + 1", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 1")) -- Move all windows to workspace 1
hl.bind("SUPER + CTRL + 2", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 2")) -- Move all windows to workspace 2
hl.bind("SUPER + CTRL + 3", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 3")) -- Move all windows to workspace 3
hl.bind("SUPER + CTRL + 4", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 4")) -- Move all windows to workspace 4
hl.bind("SUPER + CTRL + 5", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 5")) -- Move all windows to workspace 5
hl.bind("SUPER + CTRL + 6", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 6")) -- Move all windows to workspace 6
hl.bind("SUPER + CTRL + 7", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 7")) -- Move all windows to workspace 7
hl.bind("SUPER + CTRL + 8", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 8")) -- Move all windows to workspace 8
hl.bind("SUPER + CTRL + 9", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 9")) -- Move all windows to workspace 9
hl.bind("SUPER + CTRL + 0", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 10")) -- Move all windows to workspace 10

--#/# bindl = Mouse side buttons to switch workspaces
hl.bind("mouse:275", hl.dsp.exec_cmd("hyprctl dispatch workspace -1"), { locked = true }) -- BTN_SIDE
hl.bind("mouse:276", hl.dsp.exec_cmd("hyprctl dispatch workspace +1"), { locked = true }) -- BTN_EXTRA
