-- adibayu_tiling.lua ← Quattro DE-DUPED rewrite (2026-09-08)
-- Stock Quattro (default tiling) already covers: close-all, split, pseudo,
-- group-toggle, pop, fullscreen, movefocus, TAB workspaces, ALT+Tab cycling,
-- swap, scroll, mouse drag/resize. Those are NOT duplicated here (double-fire
-- would toggle twice / skip workspaces). This module keeps ONLY what stock
-- lacks: scratchpads, winedit submap, moveTo scripts, custom keys.
-- Key case normalized to stock/XKB-canonical forms (Lua parser is
-- case-sensitive — stock comment confirms for comma; verified overlap).

-- ── Stock-key reclaim: these keys are bound by stock Quattro AND by our
-- custom modules below (different actions). Unbind stock FIRST so only ONE
-- action fires (hl.unbind removes existing binds; ours bind right after).
-- Verified against /usr/share/omarchy/default/hypr/bindings/*.lua.
hl.unbind("SUPER + T") -- stock float-toggle; ours centers 1280x720
hl.unbind("SUPER + Home") -- stock save-width; ours focuses workspace 1
hl.unbind("SUPER + W") -- stock close-window; ours opens Network panel
hl.unbind("SUPER + X") -- stock universal-cut; ours enters winedit
hl.unbind("SUPER + SHIFT + B") -- stock browser; ours toggles browser scratchpad
hl.unbind("SUPER + SHIFT + LEFT") -- stock swap; ours moves window across workspaces
hl.unbind("SUPER + SHIFT + RIGHT") -- stock swap; ours moves window across workspaces
hl.unbind("SUPER + CTRL + A") -- stock audio panel; ours moves to waydroid scratchpad
hl.unbind("SUPER + CTRL + B") -- stock bluetooth panel; ours moves to browser scratchpad
hl.unbind("SUPER + CTRL + C") -- stock capture menu; ours moves to chatgpt scratchpad
hl.unbind("SUPER + CTRL + D") -- stock display panel; ours moves to down scratchpad
hl.unbind("SUPER + CTRL + E") -- stock emoji picker; ours moves to file scratchpad
hl.unbind("SUPER + CTRL + K") -- stock herdr keybindings; ours moves to kitty scratchpad
hl.unbind("SUPER + CTRL + O") -- stock toggle-menu; ours moves to obsidian scratchpad
hl.unbind("SUPER + CTRL + Q") -- stock calculator; ours force-kills window
hl.unbind("SUPER + CTRL + T") -- stock btop activity; ours shows time
hl.unbind("SUPER + CTRL + V") -- stock clipboard manager; ours moves to video scratchpad
hl.unbind("SUPER + CTRL + W") -- stock network panel; ours moves to whatsapp scratchpad
hl.unbind("SUPER + CTRL + LEFT") -- stock group-focus; ours focuses workspace left
hl.unbind("SUPER + CTRL + RIGHT") -- stock group-focus; ours focuses workspace right

-- # Close windows (stock close = SUPER+W, unbound above; Q/END uniquely ours) (stock close = SUPER+W; Q/END are uniquely ours)
hl.bind("SUPER + Q", hl.dsp.window.close(), { description = "Close active window" })
hl.bind("SUPER + END", hl.dsp.window.close(), { description = "Close active window" })
-- bindc = , mouse:274, killactive # Middle click on a window to close it
hl.bind("SUPER + CTRL + Q", hl.dsp.exec_cmd("hyprctl kill")) -- Forcefully zap a window
hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill")) -- Quit active window and all open instances

-- # Group nav on brackets (stock uses CTRL+arrows/ALT+TAB; these keys are unique)
hl.bind("SUPER + bracketleft", hl.dsp.group.prev())
hl.bind("SUPER + bracketright", hl.dsp.group.next())

-- Resize active window with SUPER CTRL (stock uses code:NN; these keys unique)
hl.bind("SUPER + CTRL + apostrophe", hl.dsp.window.resize({ x = 100, y = 0, relative = true })) -- Increase window width with keyboard
hl.bind("SUPER + CTRL + semicolon", hl.dsp.window.resize({ x = -100, y = 0, relative = true })) -- Reduce window width with keyboard
-- NOTE: SUPER+CTRL+UP/DOWN intentionally NOT bound to resize here — those
-- keys drive the up/down scratchpads below (same-key collision in .conf era
-- too). Window resizing lives on SUPER+CTRL+Apostrophe/Semicolon above and
-- on stock SUPER+code:20/21 binds.

-- special & hidden workspaces (unique scratchpad system)
hl.bind("SUPER + CTRL + B", hl.dsp.window.move({ workspace = "special:browser", follow = false })) -- Move to scratchpad
hl.bind("SUPER + SHIFT + B", hl.dsp.workspace.toggle_special("browser"))

hl.bind("SUPER + SHIFT + M", hl.dsp.workspace.toggle_special("music"))
hl.bind("SUPER + CTRL + M", hl.dsp.window.move({ workspace = "special:music", follow = false }))

hl.bind("SUPER + SHIFT + E", hl.dsp.workspace.toggle_special("file"))
hl.bind("SUPER + CTRL + E", hl.dsp.window.move({ workspace = "special:file", follow = false }))

hl.bind("SUPER + SHIFT + D", hl.dsp.workspace.toggle_special("down"))
hl.bind("SUPER + CTRL + DOWN", hl.dsp.workspace.toggle_special("down"))
hl.bind("SUPER + CTRL + D", hl.dsp.window.move({ workspace = "special:down", follow = false }))

hl.bind("SUPER + SHIFT + U", hl.dsp.workspace.toggle_special("up"))
hl.bind("SUPER + CTRL + UP", hl.dsp.workspace.toggle_special("up"))
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

-- Stock binds SUPER+T (float toggle); ours centers 1280x720 instead.
-- Unbind stock first so only ONE action fires (verified hl.unbind in source).
hl.unbind("SUPER + T")
-- Toggle focused window between normal and 1280x720 centered
hl.bind("SUPER + T", hl.dsp.exec_cmd("hyprctl dispatch togglefloating && hyprctl dispatch resizeactive exact 1280 720 && hyprctl dispatch centerwindow"))

hl.bind("SUPER + D", hl.dsp.window.fullscreen({ mode = "maximized" }), { description = "Maximize" })
-- bindd = SUPER SHIFT, F, Spoof Fullscreen, fullscreenstate, 0 3

-- Stock binds SUPER+Home (save window width); ours focuses workspace 1.
-- Unbind FIRST (removes stock's), then bind ours — order matters.
hl.unbind("SUPER + Home")
hl.bind("SUPER + Home", hl.dsp.focus({ workspace = "1" }))
-- Workspaces (keysyms; stock uses code:NN — both fire harmlessly on same target)
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

hl.bind("SUPER + SHIFT + Home", hl.dsp.window.move({ workspace = "1" }))
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

-- bind = Super+Alt, Left, movewindow, l # [hidden]
-- bind = Super+Alt, Right, movewindow, r # [hidden]
-- bind = Super+Alt, Up, movewindow, u # [hidden]
-- bind = Super+Alt, Down, movewindow, d # [hidden]

-- # Resize active window
-- binde = SUPER, Semicolon, splitratio, -0.1 # adjust split ratio
-- binde = SUPER, Apostrophe, splitratio, +0.1 # adjust split ratio
-- binde = SUPER, F1, splitratio, -0.1   # adjust split ratio
-- binde = SUPER, F2, splitratio, +0.1   # adjust split ratio

--#/# bind = Super+Shift, Scroll ↑/↓,, # Send to workspace left/right
hl.bind("SUPER + SHIFT + mouse_down", hl.dsp.window.move({ workspace = "r-1" })) -- [hidden]
hl.bind("SUPER + SHIFT + mouse_up", hl.dsp.window.move({ workspace = "r+1" })) -- [hidden]

--#/# bind = Super+Shift, Page_↑/↓,, # Send to workspace left/right
hl.bind("SUPER + SHIFT + Page_Down", hl.dsp.window.move({ workspace = "r+1" })) -- [hidden]
hl.bind("SUPER + SHIFT + Page_Up", hl.dsp.window.move({ workspace = "r-1" })) -- [hidden]

--#/# move window to left/right workspaces
hl.bind("SUPER + SHIFT + RIGHT", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind("SUPER + SHIFT + LEFT", hl.dsp.window.move({ workspace = "r-1" }))

--#/# bind = Ctrl+Super, ←/→,, # Focus left/right
hl.bind("CTRL + SUPER + RIGHT", hl.dsp.focus({ workspace = "r+1" })) -- [hidden]
hl.bind("CTRL + SUPER + LEFT", hl.dsp.focus({ workspace = "r-1" })) -- [hidden]

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
    hl.bind("LEFT", hl.dsp.window.move({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind("RIGHT", hl.dsp.window.move({ x = 10, y = 1, relative = true }), { repeating = true })
    hl.bind("UP", hl.dsp.window.move({ x = 0, y = -10, relative = true }), { repeating = true })
    hl.bind("DOWN", hl.dsp.window.move({ x = 0, y = 10, relative = true }), { repeating = true })

    -- --- Resize active window with SHIFT + arrows ---
    hl.bind("SHIFT + LEFT", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind("SHIFT + RIGHT", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
    hl.bind("SHIFT + UP", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
    hl.bind("SHIFT + DOWN", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })

    -- Exit Window Edit Mode
    hl.bind("Escape", hl.dsp.submap("reset"))
    hl.bind("Return", hl.dsp.submap("reset"))
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
