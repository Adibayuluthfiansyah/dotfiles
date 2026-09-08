-- clipboard.lua ← bindings/clipboard.conf (4 active binds)
-- NOTE: send_shortcut takes a TABLE { mods, key } in Lua (source-verified).
-- The python converter emitted positional args — that form is WRONG, this is right.
hl.bind("SUPER + C", hl.dsp.send_shortcut({ mods = "CTRL", key = "Insert" }), { description = "Universal copy" })
hl.bind("SUPER + V", hl.dsp.send_shortcut({ mods = "SHIFT", key = "Insert" }), { description = "Universal paste" })
hl.bind("SUPER + SHIFT + X", hl.dsp.send_shortcut({ mods = "CTRL", key = "X" }), { description = "Universal cut" })
hl.bind("SUPER + CTRL + G", hl.dsp.exec_cmd("omarchy-launch-walker -m clipboard"), { description = "Clipboard manager" })
