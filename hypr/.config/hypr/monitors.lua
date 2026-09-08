-- monitors.lua ← monitors.conf (only 1 active line + GDK_SCALE env)
-- Active config: any monitor → preferred mode, auto position, 1.2x scale.
hl.env("GDK_SCALE", "auto")

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1.2,
})
