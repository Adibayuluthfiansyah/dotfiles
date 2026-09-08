-- utilities.lua ← Quattro-native rewrite (2026-09-08)
-- OLD file drove walker/mako/waybar (ALL REMOVED in Quattro).
-- Stock Quattro already covers: menu/space/esc/poweroff/K, bar toggle,
-- bg/theme switchers, transparency+gaps toggles, comma notifications,
-- idle/nightlight toggles, PRINT captures, share. Those are NOT duplicated.
-- This module keeps ONLY keys stock does not bind:
--   time · battery · Network panel (W) · Bluetooth panel (Z)

-- Waybar-less information (rewritten: notify helpers, same keys)
hl.bind("SUPER + CTRL + T", hl.dsp.exec_cmd("omarchy-notification-time"), { description = "Show time" })
hl.bind("SUPER + CTRL + X", hl.dsp.exec_cmd("omarchy-notification-battery"), { description = "Show battery remaining" })

-- Network panel (was omarchy-launch-wifi, REMOVED) — keep user's key
hl.bind("SUPER + W", hl.dsp.exec_cmd("omarchy-shell shell toggle omarchy.network"), { description = "Network" })

-- Bluetooth panel (was blueberry, never installed) — keep user's key
hl.bind("SUPER + Z", hl.dsp.exec_cmd("omarchy-shell shell toggle omarchy.bluetooth"), { description = "Bluetooth" })

-- Apple Display brightness: no Apple display on this machine (IdeaPad);
-- omarchy-brightness-display-apple exists but its CLI is unverified.
-- Kept for reference, re-enable only with an Apple display attached:
-- hl.bind("CTRL + F1", hl.dsp.exec_cmd("omarchy-brightness-display-apple -5000"), { description = "Apple Display brightness down" })
-- hl.bind("CTRL + F2", hl.dsp.exec_cmd("omarchy-brightness-display-apple +5000"), { description = "Apple Display brightness up" })
-- hl.bind("SHIFT + CTRL + F2", hl.dsp.exec_cmd("omarchy-brightness-display-apple +60000"), { description = "Apple Display full brightness" })
