-- autostart.lua ← autostart.conf (order preserved 1:1)
-- Every exec-once becomes an exec_cmd on the hyprland.start event.
-- Shell features ($(), &&, ;) are preserved verbatim: exec_cmd runs via sh.
hl.on("hyprland.start", function()
    hl.exec_cmd("uwsm-app -- hypridle")
    hl.exec_cmd("uwsm-app -- mako")
    hl.exec_cmd("uwsm-app -- waybar")
    hl.exec_cmd("uwsm-app -- fcitx5")
    hl.exec_cmd("uwsm-app -- swaybg -i ~/.config/omarchy/current/background -m fill")
    hl.exec_cmd("uwsm-app -- swayosd-server")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("omarchy-cmd-first-run")

    -- Slow app launch fix -- set systemd vars
    hl.exec_cmd("systemctl --user import-environment $(env | cut -d'=' -f 1)")
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")

    hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=secrets")
    -- NOTE: single-quoted Lua string because the command has nested "quotes"
    hl.exec_cmd('nwg-dock-hyprland -i 25 -w 5 -mb 10 -x -s style.css -c "rofi -show drun"')
end)
