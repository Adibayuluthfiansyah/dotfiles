# Migrasi Config Hyprland: hyprlang (.conf) → Lua

- Tanggal dibuat: 2026-08-13
- Versi saat ini: Hyprland 0.56.2-1, Omarchy 3.8.2 (stable, generasi .conf)
- Backup: `~/.config/hypr.bak.1786556388` + `~/.config/hypr.bak.1788874743` (fresh, pre-migration)
- Status: **MODUL LUA SELESAI DIBANGUN (2026-09-08, belum flip)** — 5 gelombang,
  commit per gelombang di repo dotfiles. Entry staging:
  `hyprland.lua.staging` (INERT sampai di-rename jadi `hyprland.lua`).
  Sesi live masih jalan `.conf` normal, `configerrors` bersih.
- Validasi statis: harness stub `hl` (syntax + require graph + runtime,
  341 calls) + cross-check converter `hyprconf2lua` + API terverifikasi ke
  source Hyprland (dsp methods, rule fields, gesture actions,
  HyprGlass README).
- Diketahui hilang 1 bind: `SUPER SHIFT+T workspaceopt allfloat`
  (tidak ada padanan Lua di source) — lihat laporan gelombang 4.
- Theme Koyanagi di-frozen jadi `theme.lua` (snapshot 2026-09-08);
  wajib re-snapshot tiap `omarchy theme set`.
- Flip (aktivasi) butuh RESTART Hyprland (logout/login), bukan reload.
  Rollback: hapus/rename `hyprland.lua` + restart → `.conf` aktif lagi.
- Warning: "You are using the .conf config format, support for which will be
  removed in Hyprland 0.57." (deprecation notice, PR hyprwm/Hyprland #15538)

## Keputusan (disetujui 2026-08-13)

- **D1 — Basis default:** pakai default Lua Omarchy 4.0 sebagai basis, tulis
  ulang/override HANYA custom: `adibayu_*`, delta lookandfeel/animations/rules/monitors.
  Jangan konversi 1:1 semua file.
- **D2 — adibayu_apps.conf:** tetap OFF saat migrasi (tidak diaktifkan kembali).
- **D3 — Gesture/input:** seluruh detail `adibayu_input.conf` (termasuk gesture
  4-jari swipe) dipertahankan PERSIS seperti sekarang, tanpa perubahan preventif.

## A. Bentuk target

    ~/.config/hypr/
    ├── hyprland.lua              # entry: require omarchy defaults + module custom
    ├── colors.lua                # ← colors.conf (palet Material; return table)
    ├── adibayu_input.lua            # ← adibayu_input.conf (input, touchpad, gestures) [D3]
    ├── adibayu_tiling.lua           # ← adibayu_tiling.conf (terbesar: ~200 baris + submap winedit)
    ├── adibayu_bindings.lua         # ← adibayu_bindings.conf (launcher apps)
    ├── adibayu_media_key.lua        # ← adibayu_media_key.conf (media keys + $osdclient)
    ├── adibayu_apps.lua             # TIDAK dibuat [D2]
    ├── monitors.lua              # ← monitors.conf (env GDK_SCALE + hl.monitor)
    ├── rules.lua                 # ← rules.conf (window rules)
    ├── scripts/                  # TIDAK BERUBAH (bash via hl.dsp.exec_cmd)
    ├── hypridle.conf, hyprlock.conf, hyprsunset.conf, xdph.conf
    │                             # TIDAK BERUBAH — hypr* tools tetap hyprlang
    └── shaders/, workspaces.conf # tidak berpengaruh

## B. Mapping konstruk (bentuk API dari example resmi hyprland.lua)

| Konstruk lama | Bentuk baru di Lua |
|---|---|
| `monitor = , preferred, auto, 1.2` | `hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })` |
| `env = XCURSOR_SIZE,28` | `hl.env("XCURSOR_SIZE", "28")` |
| `general { gaps_in = 5 ... }` | `hl.config({ general = { gaps_in = 5, ... } })` (nested, 1:1) |
| `col.active_border = rgba(..) rgba(..) 45deg` | `hl.config({ general = { col = { active_border = { colors = {...}, angle = 45 } } } })` |
| `bezier = steel, 0.30, ...` | `hl.curve("steel", { type = "bezier", points = {{0.30,0.85},{0.40,1.00}} })` |
| `animation = windows, 1, 2.6, mechDrive` | `hl.animation({ leaf = "windows", enabled = true, speed = 2.6, bezier = "mechDrive" })` |
| `exec-once = uwsm-app -- waybar` | `hl.on("hyprland.start", function() hl.exec_cmd("uwsm-app -- waybar") end)` |
| `bindd = SUPER, Return, Terminal, exec, ...` | `hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(...))` — deskripsi/flag via tabel opsi |
| `bind = SUPER, G, togglegroup` | `hl.bind(..., hl.dsp.<group>())` — dispatcher baru `hl.dsp.*`, verifikasi ke wiki |
| `bindm/binde/bindl/bindld/bindeld` | flags opsi `{ mouse = true }`, `{ repeating = true }`, `{ locked = true }` |
| `submap = winedit / bind = SUPER X, submap, winedit` | API submap Lua — **perlu diverifikasi** saat eksekusi |
| `windowrulev = float, class:^(kitty-float)$` | `hl.window_rule({ name = "...", match = { class = "^(kitty-float)$" }, float = true })` — named rules |
| `gesture = 3, horizontal, workspace` | `hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })` |
| `source = ~/.config/hypr/…` | `require("...")` — **scoping beda**: variabel antar modul tidak saling lihat |
| `$terminal`, `$HYPRSCRIPTS`, `$osdclient` | `local terminal = ...` per-modul, atau modul `config.lua` yang di-require |
| `exec` dengan bash `$(...)`, `&&`, multi-line | tetap string `hl.dsp.exec_cmd("...")` (via shell — perlu diuji) |

## C. Inventory per file — effort & risiko

| File | Ukuran | Effort | Catatan |
|---|---|---|---|
| `hyprland.conf` | 36 baris | trivial | jadi kerangka `require()`; pertahankan urutan override (later wins) |
| `colors.conf` | ~60 var | mudah | `return` table; modul lain wajib require sendiri |
| `envs.conf` | ~20 env | mudah | `hl.env()`; blok `xwayland{}`, `ecosystem{}` → `hl.config()` |
| `autostart.conf` | 13 exec-once | mudah | jaga urutan `sleep 3`; cek duplikat dgn autostart default 4.0 |
| `monitors.conf` | 1 line aktif | trivial | |
| `adibayu_input.conf` | 45 baris | sedang | [D3] pertahankan PERSIS; blok `gestures{}` API baru perlu riset wiki |
| `adibayu_bindings.conf` | 45 baris | sedang | `$terminal`/`$browser` → local vars |
| `adibayu_tiling.conf` | 220 baris | **tinggi** | ~140 bind aktif + submap winedit; mapping pakai referensi (skill `hyprland-lua-migration`, wiki) |
| `adibayu_media_key.conf` | 27 baris | sedang | `$osdclient` berisi `$(hyprctl monitors -j \| jq ...)` — uji command substitution |
| `rules.conf` | ~15 aktif | sedang | 1:1; efek jadi field `window_rule`/`workspace_rule` |
| `bindings/utilities.conf` | 52 baris | rendah | kalau identik dgn default 4.0 → drop, cukup require default |
| `bindings/clipboard.conf` | 5 baris | rendah | sama (`sendshortcut` — cek nama `hl.dsp` baru) |
| `animations/omarchy_animations.conf` | 49 animasi | menengah | cek dulu default 4.0; kalau setara → pakai default |
| theme `hyprland.conf` | 4KB | nol | digenerate otomatis (`omarchy theme set` ulang), jangan edit manual |
| `adibayu_apps.conf` | 14 source | nol | [D2] tetap OFF |

## D. Risiko utama & perangkap

1. Scoping per-module — `$terminal` tidak lintas file.
2. Tidak ada converter resmi — verifikasi tiap bind via wiki "Configuring in Lua"
   + `hyprctl` REPL lua (fitur 0.56).
3. Submap (winedit), gesture 4-jari, sendshortcut, workspaceopt — API belum
   jelas dari example; wajib cek sumber resmi saat eksekusi.
4. Autostart dobel — custom + default 4.0 jangan sampai jalan bersamaan.
5. Theme file regenerasi otomatis — jangan dipegang manual.
6. Jangan hapus backup .conf sampai 0.57 rilis & semua stabil (A/B test aman
   di 0.56.x).

## E. Urutan eksekusi (SAAT Omarchy 4.0 stabil rilis)

1. `cp -r ~/.config/hypr ~/.config/hypr.bak.$(date +%s)`
2. `omarchy update` → pastikan `omarchy version` ≥ 4.0, migration Lua jalan
3. Kalau belum dapat `hyprland.lua`: `omarchy refresh hyprland` (auto backup)
4. Baseline check: `hyprctl reload` → `hyprctl configerrors` bersih → desktop normal
5. Tulis module custom (`colors.lua`, `adibayu_*.lua` [D3], `rules.lua`,
   `monitors.lua`, delta lookandfeel/animations [D1]) + rakit `hyprland.lua`
6. Verifikasi bertahap per-module: save → `hyprctl reload` → `configerrors` →
   uji fungsional (kitty, scratchpad `special:*`, winedit, media key, gesture [D3])
7. `omarchy theme set "<theme saat ini>"` (`omarchy theme current` untuk tahu nama)
8. Komparasi akhir: daftar bind lama vs baru (tidak ada yang hilang)

## F. Status pelacakan

- [x] Backup .conf dibuat (2026-08-13, `~/.config/hypr.bak.1786556388`)
- [ ] Omarchy 4.0 stabil rilis (cek ± akhir Sept/awal Okt 2026)
- [ ] `omarchy update` + migration Lua jalan
- [ ] Baseline `configerrors` bersih
- [ ] Module custom ditulis & `hyprland.lua` dirakit
- [ ] Verifikasi per-module selesai
- [ ] Theme diregenerasi
- [ ] Komparasi bind lolos