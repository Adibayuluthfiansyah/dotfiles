Personal tmux configuration - TokyoNight storm theme with seamless Neovim integration.

## Setup

```bash
git clone https://github.com/Adibayuluthfiansyah/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow --no-folding tmux
Requirements
- tmux 3.2+ (required for display-popup)
- TPM (https://github.com/tmux-plugins/tpm) (installed automatically on first run)
- Nerd Font (for status bar icons)
Keybind Reference
Prefix
Key	Description
C-Space	Prefix key (all commands below follow this)
Splits & Navigation
Key	Description
C-Space h	Split horizontally (left-right)
C-Space v	Split vertically (top-bottom)
C-h / C-j / C-k / C-l	Navigate panes — works both inside and outside Neovim (via vim-tmux-navigator)
C-Space x	Kill current pane
Windows (Tabs)
Key	Description
C-Space c	Create new window
C-Space 1-9	Switch to window 1-9
C-Space n	Next window
C-Space p	Previous window
C-Space ,	Rename current window
C-Space k	Kill current window
Floating Popup
Key	Description
C-Space p	Open floating terminal (80 columns, 60% height)
Esc	Close popup
Copy Mode
Key	Description
C-Space [	Enter copy mode (vi keys)
v	Begin selection
y	Copy selection to clipboard (requires tmux-yank)
C-Space ]	Paste
Session
Key	Description
C-Space d	Detach session (runs in background)
C-Space C	Create new session
C-Space R	Rename session
C-Space K	Kill current session
C-Space (	Previous session
C-Space )	Next session
Config
Key	Description
C-Space q	Reload tmux configuration
Features
- TokyoNight storm theme — matches Neovim colorscheme
- Transparent status bar
- vim-tmux-navigator — unified C-h/j/k/l navigation across tmux panes and Neovim splits
- tmux-yank — copy to system clipboard
- tmux-resurrect / continuum (via TPM) — session persistence
- Git status — current branch and changes in status bar
Related
Neovim configuration is maintained separately:
https://github.com/Adibayuluthfiansyah/nvim-config (https://github.com/Adibayuluthfiansyah/nvim-config)
