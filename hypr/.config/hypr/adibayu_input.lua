-- adibayu_input.lua ← adibayu_input.conf (D3: gestures kept EXACTLY as-is)
-- https://wiki.hyprland.org/Configuring/Variables/#input
hl.config({
    input = {
        kb_layout = "us",
        numlock_by_default = true,
        repeat_delay = 200,
        repeat_rate = 20,
        kb_options = "altwin:swap_alt_win",
        follow_mouse = 1,
        sensitivity = 0.5,
        -- accel_profile = flat
        -- scroll_factor = 0.8

        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
            clickfinger_behavior = true,
            scroll_factor = 1,
        },
    },
})

-- gestures {
--     # workspace_swipe = true
-- }

-- NOTE: direction strings passed verbatim to the same parser as hyprlang.
-- "dispatcher, togglespecialworkspace, X" has NO direct Lua equivalent;
-- verified mapping (Hyprland source): action="special" + workspace_name="X"
-- (CSpecialWorkspaceGesture toggles the named special workspace).
hl.gesture({ fingers = 4, direction = "swipe", action = "move" })
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
-- gesture = 3, up, dispatcher, fullscreen, 1
-- gesture = 2, pinch, float
hl.gesture({ fingers = 3, direction = "down", action = "special", workspace_name = "down" })
hl.gesture({ fingers = 3, direction = "up", action = "special", workspace_name = "up" })
-- gesture = 3, up, togglespecialworkspace
-- gesture = 4, up, dispatcher, global, quickshell:overviewToggle
-- gesture = 4, down, dispatcher, global, quickshell:overviewClose
hl.config({
    gestures = {
        workspace_swipe_distance = 500,
        workspace_swipe_cancel_ratio = 0.2,
        workspace_swipe_min_speed_to_force = 5,
        workspace_swipe_direction_lock = true,
        workspace_swipe_direction_lock_threshold = 10,
        workspace_swipe_create_new = true,
    },
})
