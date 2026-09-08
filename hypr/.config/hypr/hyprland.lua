-- hyprland.lua.STAGING — full Lua entrypoint (NOT live until renamed to hyprland.lua)
-- Require order mirrors the old hyprland.conf source order (later wins).
-- Flip procedure: `mv hyprland.lua.staging hyprland.lua` + RESTART Hyprland
-- (logout/login — reload is NOT enough to switch .conf ↔ .lua).
-- Rollback: delete/rename hyprland.lua + RESTART → old .conf takes over.
package.path = os.getenv("HOME") .. "/.config/hypr/?.lua;" .. package.path

require("colors") -- palette table (no hl calls; required explicitly per module)
require("lookandfeel") -- base delta: general/group/misc/decoration/dwindle/...
require("monitors") -- GDK_SCALE + preferred/auto/1.2
require("adibayu_input") -- input/touchpad/gestures (D3: kept EXACTLY)
require("adibayu_tiling") -- ~117 binds + winedit submap (workspaceopt omitted: no Lua equiv)
require("adibayu_bindings") -- app launcher binds
require("envs") -- env vars + xwayland + ecosystem
require("autostart") -- exec-once set (order preserved)
require("rules") -- 25 window rules
require("adibayu_media_key") -- swayosd media keys + playerctl
require("bindings.utilities") -- walker/mako/screenshot/etc binds
require("bindings.clipboard") -- send_shortcut binds
require("theme") -- ⚠️ Koyanagi SNAPSHOT 2026-09-08 (re-snapshot after theme set!)
require("animations.omarchy_animations") -- easeOutQuint set (overrides theme anims)
require("adibayu_macos") -- macOS override, LAST look block so it wins
require("hyprglass") -- HyprGlass plugin (guarded; hyprpm autoloads the .so)
