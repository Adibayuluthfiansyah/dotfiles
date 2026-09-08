-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings (our app binds cover our needs):
omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })

-- ── Personal modules (Adibayu) — loaded LAST so they win over defaults.
-- These adibayu_* files are never touched by Omarchy upgrades (not in any
-- refresh/retire list); after an upgrade only this entry (+hypr/monitors.lua)
-- needs re-applying from git. Stock hypr/*.lua files stay pristine.
require("lookandfeel")
require("adibayu_input")
require("adibayu_tiling")
require("adibayu_bindings")
require("envs")
require("rules")
require("adibayu_media_key")
require("bindings.utilities")
require("theme") -- Koyanagi snapshot 2026-09-08; re-snapshot after `theme set`
require("animations.omarchy_animations")
require("adibayu_macos") -- macOS override, keep LAST for look
require("hyprglass") -- guarded; needs hyprpm plugin loaded
-- NOT required: autostart.lua (launched waybar/mako/swayosd — retired;
-- stock autostart stands) and bindings/clipboard.lua (deleted; stock
-- clipboard is terminal-aware and superior).
