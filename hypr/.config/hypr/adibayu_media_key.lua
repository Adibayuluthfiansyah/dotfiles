-- adibayu_media_key.lua ← Quattro-native rewrite (2026-09-08)
-- OLD file drove everything through swayosd-client (REMOVED in Quattro).
-- Stock Quattro already binds ALL XF86 keys natively (volume/brightness/
-- precise variants/playerctl) — those are intentionally NOT duplicated here.
-- This module keeps ONLY the user's unique extras:
--   CTRL+O switch output · CTRL+ALT+arrows volume · CTRL+SHIFT+ALT+arrows brightness
-- Commands verified against /usr/share/omarchy/bin on 4.0.2.

-- Switch audio output (stock moved this to SHIFT+XF86AudioMute; keep user's key)
hl.bind("CTRL + O", hl.dsp.exec_cmd("omarchy-audio-output-switch"), { description = "Switch audio output", locked = true })

-- Volume alternatives (no stock equivalent on these keys)
hl.bind("CTRL + ALT + right", hl.dsp.exec_cmd("omarchy-audio-output-volume raise"), { description = "Volume up" })
hl.bind("CTRL + ALT + left", hl.dsp.exec_cmd("omarchy-audio-output-volume lower"), { description = "Volume down" })

-- Brightness alternatives (no stock equivalent on these keys)
hl.bind("CTRL + SHIFT + ALT + right", hl.dsp.exec_cmd("omarchy-brightness-display +5%")) -- Brightness Up
hl.bind("CTRL + SHIFT + ALT + left", hl.dsp.exec_cmd("omarchy-brightness-display 5%-")) -- Brightness down
