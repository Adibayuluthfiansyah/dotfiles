-- adibayu_bindings.lua ← adibayu_bindings.conf (14 active binds)
-- Stock binds SUPER+RETURN (Foot) and SUPER+SHIFT+RETURN (browser);
-- ours open kitty/alacritty instead. Unbind stock FIRST so only ONE
-- terminal opens (order matters: unbind removes existing, then we bind).
hl.unbind("SUPER + RETURN")
hl.unbind("SUPER + SHIFT + RETURN")
-- NOTE: $vars are Lua locals here (hyprlang $vars were file-global;
-- in Lua each module is scoped, so locals are declared per module).
local terminal  = "kitty"
local terminal2 = "alacritty"
local browser   = "omarchy-launch-browser"
local browser2  = "firefox"

-- NOTE: $(...) shell substitutions are preserved verbatim (exec_cmd runs via sh).
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal .. " --working-directory $(omarchy-cmd-terminal-cwd)"), { description = "kitty" })
hl.bind("SUPER + ALT + RETURN", hl.dsp.exec_cmd(terminal .. " --class kitty-float"), { description = "kitty-float" })
hl.bind("SUPER + SHIFT + RETURN", hl.dsp.exec_cmd(terminal2 .. " --working-directory $(omarchy-cmd-terminal-cwd)"), { description = "alacritty" })

hl.bind("SUPER + E", hl.dsp.exec_cmd("uwsm app -- nautilus --new-window"), { description = "File manager" })
-- thunar NOT INSTALLED on Quattro (retired); bind kept for reference:
-- hl.bind("SUPER + ALT + E", hl.dsp.exec_cmd("uwsm app -- thunar"), { description = "File manager" })
hl.bind("SUPER + B", hl.dsp.exec_cmd(browser), { description = "Browser" })
hl.bind("SUPER + ALT + B", hl.dsp.exec_cmd(browser2), { description = "incognito" })
hl.bind("SUPER + ALT + X", hl.dsp.exec_cmd("chromium --incognito"), { description = "incognito" })

hl.bind("SUPER + N", hl.dsp.exec_cmd(terminal .. " -e nvim"), { description = "Neovim" })
-- yazi NOT INSTALLED on Quattro; bind kept for reference:
-- hl.bind("SUPER + S", hl.dsp.exec_cmd(terminal .. " -e yazi"), { description = "Yazi" })

-- NOTE: plain bind (no description in .conf) — kept description-less 1:1.
hl.bind("SUPER + H", hl.dsp.exec_cmd('sh -c "' .. terminal .. ' -e nvim ~/.config/hypr/"'))

-- Tmux in kitty (stock preinstalled bind lost to preinstalled=false flag).
-- NOTE: was SUPER+ALT+RETURN — that key is kitty-float above. ALT+M is free.
hl.bind("SUPER + ALT + M", hl.dsp.exec_cmd(terminal .. " -e tmux"), { description = "Tmux" })

-- If your web app url contains #, type it as ## to prevent hyprland treating it as comments
hl.bind("SUPER + A", hl.dsp.exec_cmd('omarchy-launch-webapp "https://chatgpt.com"'), { description = "ChatGPT" })
hl.bind("SUPER + Y", hl.dsp.exec_cmd('omarchy-launch-webapp "https://youtube.com/"'), { description = "YouTube" })
hl.bind("SUPER + M", hl.dsp.exec_cmd('omarchy-launch-webapp "https://music.youtube.com/"'), { description = "YouTube Music" })
hl.bind("SUPER + I", hl.dsp.exec_cmd('omarchy-launch-webapp "https://instagram.com/"'), { description = "Instagram" })
