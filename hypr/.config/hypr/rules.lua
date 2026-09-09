-- rules.lua ← rules.conf (active rules only, 1:1, comments kept as comments)
-- Verified against Hyprland source (0.56.x):
--   match keys: class/title = regex strings, float = bool (NOT "floating")
--   effects: opacity/size/workspace/suppress_event = strings,
--            float/center = bool, rounding = int
-- NOTE: workspace "silent" stays inside the workspace string (no separate flag).

-- Glass effect for common apps
hl.window_rule({
    name = "glass-terminals",
    match = { class = "^(kitty|Alacritty|foot)$" },
    opacity = "0.92 0.92",
})

hl.window_rule({
    name = "glass-files",
    match = { class = "^(thunar|org.gnome.Nautilus)$" },
    opacity = "0.95 0.95",
})

hl.window_rule({
    name = "glass-browsers",
    match = { class = "^(chromium|firefox)$" },
    opacity = "0.97 0.97",
})

hl.window_rule({
    name = "whatsapp-size",
    match = { class = "^(chrome-web.whatsapp.com__-Default|blueberry.py)$" },
    size = "1100 700",
})

hl.window_rule({
    name = "kitty-float-float",
    match = { class = "^(kitty-float)$" },
    float = true,
})

hl.window_rule({
    name = "kitty-float-size",
    match = { class = "^(kitty-float)$" },
    size = "1100 700",
})

hl.window_rule({
    name = "kitty-float-center",
    match = { class = "^(kitty-float)$" },
    center = true,
})

hl.window_rule({
    name = "webapp-float",
    match = { class = "^(chrome-web.whatsapp.com__-Default|chrome-music.youtube.com__-Default)$" },
    float = true,
})

hl.window_rule({
    name = "music-size",
    match = { class = "^(chrome-music.youtube.com__-Default)$" },
    size = "1100 700",
})

hl.window_rule({
    name = "insta-float",
    match = { class = "^(chrome-instagram\\.com__-Default|blueberry.py)$" },
    float = true,
})

hl.window_rule({
    name = "insta-size",
    match = { class = "^(chrome-instagram\\.com__-Default)$" },
    size = "400 800",
})

hl.window_rule({
    name = "insta-center",
    match = { class = "^(chrome-instagram\\.com__-Default)$" },
    center = true,
})

-- Dialog & utility windows
hl.window_rule({
    name = "dialog-float",
    match = { title = "^(Open File|Save File|Preferences|Settings)$" },
    float = true,
})

hl.window_rule({
    name = "dialog-center",
    match = { title = "^(Open File|Save File|Preferences|Settings)$" },
    center = true,
})

hl.window_rule({
    name = "dialog-size",
    match = { title = "^(Open File|Save File|Preferences|Settings)$" },
    size = "600 500",
})

hl.window_rule({
    name = "dialog-opacity",
    match = { title = "^(Open File|Save File|Preferences|Settings)$" },
    opacity = "0.96 0.96",
})

-- Float + center main Mega windows
hl.window_rule({
    name = "mega-float",
    match = { class = "^(MEGAsync|MEGA)$" },
    float = true,
})

hl.window_rule({
    name = "mega-center",
    match = { class = "^(MEGAsync|MEGA)$" },
    center = true,
})

hl.window_rule({
    name = "mega-suppress",
    match = { class = "^(MEGAsync|MEGA)$" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "mega-title-float",
    match = { title = "^(MEGA.*|Login|Dialog)$" },
    float = true,
})

-- Special workspace for apps
-- NOTE: instagram match kept VERBATIM (unanchored, dots unescaped) — same regex semantics.
hl.window_rule({
    name = "special-instagram",
    match = { class = "chrome-instagram.com__-Default" },
    workspace = "special:instagram",
})

-- Launch silently
hl.window_rule({
    name = "special-whatsapp",
    match = { class = "^(chrome-web.whatsapp.com__-Default)$" },
    workspace = "special:whatsapp silent",
})

-- NOTE (2026-09-09): rule file-scratchpad dihapus — bikin SUPER+E "mati"
-- (tiap Nautilus lahir langsung dibuang sunyi ke special:file, numpuk
-- tak terlihat). Nautilus sekarang buka normal di workspace aktif.
-- Filing ke scratchpad tetap via SUPER+CTRL+E (move) + SUPER+SHIFT+E (toggle).
-- backup rule lama:
-- hl.window_rule({
--     name = "special-file",
--     match = { class = "^(org.gnome.Nautilus)$" },
--     workspace = "special:file silent",
-- })

hl.window_rule({
    name = "special-waydroid",
    match = { class = "Waydroid" },
    workspace = "special:waydroid silent",
})

hl.window_rule({
    name = "float-rounding",
    match = { float = true },
    rounding = 12,
})
