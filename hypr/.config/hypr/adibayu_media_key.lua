-- adibayu_media_key.lua ← adibayu_media_key.conf (all binds kept 1:1)
-- NOTE: $osdclient contains $(...) command substitution — preserved verbatim
-- inside a double-quoted Lua string (exec_cmd runs via sh, so it expands there).
-- bindeld = locked + repeating ; bindld = locked ; bindd = description only.
local osdclient = 'swayosd-client --monitor "$(hyprctl monitors -j | jq -r \'.[] | select(.focused == true).name\')"'

-- Laptop multimedia keys for volume and LCD brightness (with OSD)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(osdclient .. " --output-volume raise"), { description = "Volume up", locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(osdclient .. " --output-volume lower"), { description = "Volume down", locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(osdclient .. " --output-volume mute-toggle"), { description = "Mute", locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(osdclient .. " --input-volume mute-toggle"), { description = "Mute microphone", locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(osdclient .. " --brightness raise"), { description = "Brightness up", locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(osdclient .. " --brightness lower"), { description = "Brightness down", locked = true, repeating = true })

-- Precise 1% multimedia adjustments with Alt modifier
hl.bind("ALT + XF86AudioRaiseVolume", hl.dsp.exec_cmd(osdclient .. " --output-volume +1"), { description = "Volume up precise", locked = true, repeating = true })
hl.bind("ALT + XF86AudioLowerVolume", hl.dsp.exec_cmd(osdclient .. " --output-volume -1"), { description = "Volume down precise", locked = true, repeating = true })
hl.bind("ALT + XF86MonBrightnessUp", hl.dsp.exec_cmd(osdclient .. " --brightness +1"), { description = "Brightness up precise", locked = true, repeating = true })
hl.bind("ALT + XF86MonBrightnessDown", hl.dsp.exec_cmd(osdclient .. " --brightness -1"), { description = "Brightness down precise", locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(osdclient .. " --playerctl next"), { description = "Next track", locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(osdclient .. " --playerctl play-pause"), { description = "Pause", locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(osdclient .. " --playerctl play-pause"), { description = "Play", locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(osdclient .. " --playerctl previous"), { description = "Previous track", locked = true })

-- Switch audio output with Super + Mute
hl.bind("CTRL + O", hl.dsp.exec_cmd("omarchy-cmd-audio-switch"), { description = "Switch audio output", locked = true })

-- volume alternative
hl.bind("CTRL + ALT + right", hl.dsp.exec_cmd(osdclient .. " --output-volume raise"), { description = "Volume up" })
hl.bind("CTRL + ALT + left", hl.dsp.exec_cmd(osdclient .. " --output-volume lower"), { description = "Volume down" })

-- brightness alternative
hl.bind("CTRL + SHIFT + ALT + right", hl.dsp.exec_cmd(osdclient .. " --brightness raise")) -- Brightness Up
hl.bind("CTRL + SHIFT + ALT + left", hl.dsp.exec_cmd(osdclient .. " --brightness lower")) -- Brightness down
