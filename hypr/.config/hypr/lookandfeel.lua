-- lookandfeel.lua ← lookandfeel.conf
-- D1: only the DELTA vs Omarchy defaults lives here (this file IS the delta).
local activeBorderColor   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 }
local inactiveBorderColor = "rgba(595959aa)"

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 1,
        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,

        -- Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
        -- layout = master
    },
})

-- https://wiki.hypr.land/Configuring/Variables/#group
hl.config({
    group = {
        col = {
            border_active = activeBorderColor,
            border_inactive = inactiveBorderColor,
            -- col.border_locked_active = rgba(00000000)
            -- col.border_locked_inactive = rgba(00000000)
        },

        groupbar = {
            font_size = 10,
            font_family = "Inter",
            font_weight_active = "bold",
            font_weight_inactive = "normal",

            indicator_height = 0,
            indicator_gap = 5,
            height = 20,
            gaps_in = 6,
            gaps_out = 0,

            text_color = "rgb(ffffff)",
            text_color_inactive = "rgba(ffffff90)",
            col = {
                active = "rgba(00000060)",
                inactive = "rgba(00000030)",
            },

            gradients = true,
            gradient_rounding = 12,
            gradient_round_only_edges = false,
        },
    },
})

hl.config({
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        -- vfr = 1
        vrr = 1,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
        animate_manual_resizes = true,
        animate_mouse_windowdragging = true,
        enable_swallow = true,
        swallow_regex = "(foot|kitty|allacritty|Alacritty)",
        -- new_window_takes_over_fullscreen = 2
        allow_session_lock_restore = true,
        session_lock_xray = true,
        initial_workspace_tracking = false,
        focus_on_activate = true,
    },
})

hl.config({
    decoration = {
        rounding = 12,

        shadow = {
            enabled = true,
            range = 40,
            render_power = 3,
            color = "rgba(00000040)",
            offset = "0 4",
            scale = 1.0,
        },

        blur = {
            enabled = true,
            size = 10,
            passes = 3,
            new_optimizations = true,
            -- noise = 0.2
            -- brightness = 1.0
            -- contrast = 1.0
            -- vibrancy = 0.2
            -- vibrancy_darkness = 0.5
            xray = true,
            popups = true,
            ignore_opacity = true,
        },

        dim_inactive = true,
        dim_strength = 0.01,
        active_opacity = 0.96,
        inactive_opacity = 0.90,
    },
})

hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("winIn", { type = "bezier", points = { { 0.1, 1.1 }, { 0.1, 1.1 } } })
hl.curve("winOut", { type = "bezier", points = { { 0.3, -0.3 }, { 0, 1 } } })
hl.curve("liner", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 6, bezier = "wind", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 6, bezier = "winIn", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "winOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "wind", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "liner", style = "loop" })
hl.animation({ leaf = "fade", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "wind" })

-- See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        -- pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true, -- You probably want this
        force_split = 2, -- Always split on the right
        smart_split = false,
        smart_resizing = true,
        special_scale_factor = 0.95, -- Scale untuk special workspace
    },
})

-- See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
        new_on_top = true,
        mfact = 0.55,
    },
})

-- https://wiki.hypr.land/Configuring/Variables/#cursor
hl.config({
    cursor = {
        no_warps = false,
        hide_on_key_press = true,
        hide_on_touch = true,
    },
})

-- --- Waybar styling rules ---
-- layerrule = blur, waybar
-- layerrule = ignorezero, waybar
-- layerrule = noanim, waybar
-- layerrule = ignorealpha, waybar
-- layerrule = blurpopups, waybar

-- --- Waybar styling rules (iOS style) ---
-- blurls = waybar  # disabled: hyprglass layer handles waybar frosting

-- Rofi/launcher blur (blurls → layer_rule, source-verified effect keys)
hl.layer_rule({ name = "blur-rofi", match = { namespace = "rofi" }, blur = true })

-- Notification blur
hl.layer_rule({ name = "blur-notifications", match = { namespace = "notifications" }, blur = true })

-- Screenshot blur
hl.layer_rule({ name = "blur-screenshot", match = { namespace = "screenshot" }, blur = true })

-- Style Gum confirm to match terminal theme
hl.env("GUM_CONFIRM_PROMPT_FOREGROUND", "6") -- Cyan
hl.env("GUM_CONFIRM_SELECTED_FOREGROUND", "0") -- Black
hl.env("GUM_CONFIRM_SELECTED_BACKGROUND", "2") -- Green
hl.env("GUM_CONFIRM_UNSELECTED_FOREGROUND", "0") -- Black
hl.env("GUM_CONFIRM_UNSELECTED_BACKGROUND", "8") -- Dark grey
