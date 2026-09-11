# My dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

Stow create symlinks from this repo into `~/.config/`, so configs stay live-editable and version-controlled in one place.

## What's inside

| Directory | What it configures |
|-----------|-------------------|
| `hypr/` | Hyprland compositor — windows, workspace rules, animations, input, monitors, env, autostart |
| `waybar/` | Status bar — modules, styling, custom scripts (network speed, power profile) |
| `fish/` | Fish shell — aliases, functions, completions, env vars |
| `tmux/` | Tmux — TokyoNight storm theme, Neovim integration, session persistence |

## Getting started

```bash
git clone https://github.com/Adibayuluthfiansyah/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow -t ~ */
```

## Requirements

- Arch Linux (Hyprland, Waybar, Fish)
- tmux 3.2+, TPM, Nerd Font
- Neovim config: [Adibayuluthfiansyah/nvim-config](https://github.com/Adibayuluthfiansyah/nvim-config)
