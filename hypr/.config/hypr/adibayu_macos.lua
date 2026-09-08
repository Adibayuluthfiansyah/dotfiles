-- adibayu_macos.lua ← adibayu_macos.conf
-- macOS aesthetic overrides — required LAST (after theme) so it wins.
hl.config({
    general = {
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(ffffff44)", "rgba(8a94a6aa)" }, angle = 90 },
            inactive_border = "rgb(1c1e22)",
        },
        gaps_in = 6,
        gaps_out = 12,
    },
})

hl.config({
    decoration = {
        rounding = 14,
        shadow = {
            enabled = true,
            range = 36,
            render_power = 2,
            offset = "0 4",
            color = "rgba(00000045)",
        },
        active_opacity = 0.93,
        inactive_opacity = 0.82,
    },
})

hl.config({ animations = { enabled = true } })
hl.curve("spring", { type = "bezier", points = { { 0.34, 1.56 }, { 0.64, 1 } } })
hl.curve("springSoft", { type = "bezier", points = { { 0.33, 1.0 }, { 0.68, 1 } } })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 7, bezier = "spring", style = "popin 90%" })
hl.animation({ leaf = "windows", enabled = true, speed = 6, bezier = "springSoft", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "springSoft", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 6, bezier = "springSoft", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 4, bezier = "springSoft" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 4, bezier = "springSoft" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "springSoft", style = "slide" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "springSoft" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 3, bezier = "springSoft" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 3, bezier = "springSoft" })
