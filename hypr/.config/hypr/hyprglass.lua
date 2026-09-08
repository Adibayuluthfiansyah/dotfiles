-- hyprglass.lua ← hyprglass.conf (HyprGlass liquid-glass plugin)
-- Mapping verified against HyprGlass README "Lua config" section.
-- Loading: handled by hyprpm (plugin enabled:true) — the old
--   `plugin = /var/cache/hyprpm/...` line is NOT needed in Lua mode.
--   If hyprpm ever stops autoloading: `hyprctl plugin load <path>` once.
-- Guard: if the plugin is missing/broken, whole block is skipped safely.
if hl.plugin.hyprglass then
    local hg = hl.plugin.hyprglass

    hg.config({
        default_theme = "dark",
        default_preset = "macglass",
        manage_window_blur = true,

        layers = { enabled = true },
    })

    -- preset = name:macglass, glass_opacity:0.78, blur_strength:1.3, blur_iterations:3
    -- preset = name:macglass:dark, refraction_strength:0.45, ... (:dark → nested table)
    hg.preset("macglass", {
        glass_opacity = 0.78,
        blur_strength = 1.3,
        blur_iterations = 3,
        dark = {
            refraction_strength = 0.45,
            chromatic_aberration = 0.28,
            fresnel_strength = 0.45,
            specular_strength = 0.6,
            edge_thickness = 0.06,
            brightness = 0.86,
            tint_color = 0x22334415,
        },
    })

    -- preset = name:waybar_glass, ... / name:waybar_glass:dark, ...
    hg.preset("waybar_glass", {
        glass_opacity = 0.88,
        blur_strength = 0.5,
        blur_iterations = 2,
        dark = {
            refraction_strength = 0.15,
            chromatic_aberration = 0.1,
            fresnel_strength = 0.15,
            specular_strength = 0.25,
            brightness = 0.98,
            tint_color = 0x22334408,
        },
    })

    -- layers { enabled=1, namespaces=waybar, preset=subtle,
    --          namespace_presets=waybar:waybar_glass,
    --          namespace_mask_thresholds=waybar=0.005 }
    -- Whitelist is waybar-only, so the per-namespace call covers preset+threshold.
    hg.layer("waybar", { preset = "waybar_glass", mask_threshold = 0.005 })
end
