-- envs.lua ← envs.conf
-- NOTE: env changes require a Hyprland RESTART (not just reload),
-- same as with the old .conf (see note in envs.conf).

-- Cursor
hl.env("XCURSOR_SIZE", "28")
hl.env("HYPRCURSOR_SIZE", "28")
hl.env("XCURSOR_THEME", "Vimix-cursors")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")

-- Force all apps to use Wayland
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- Screen sharing (Meet, Discord, …)
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

-- XCompose file
hl.env("XCOMPOSEFILE", "~/.XCompose")

-- Don't show update news on first launch
hl.config({
    ecosystem = {
        no_update_news = true,
    },
})
