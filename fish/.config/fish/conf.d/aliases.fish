# ---------------------------
# 📁 File System
# ---------------------------
alias ls='eza -a --icons=always'
alias ll='eza -al --icons=always'
alias lt='eza -a --tree --level=1 --icons=always'
alias shutdown='systemctl poweroff'

# alias ls='eza -lh --group-directories-first --icons=auto'
# alias lsa='ls -a'
# alias lt='eza --tree --level=2 --long --icons --git'
# alias lta='lt -a'

# Fuzzy file finder with preview
alias ff='fzf --preview "bat --style=numbers --color=always {}"'

# --- Enhanced cd (zd) ---
# function zd
#     if test (count $argv) -eq 0
#         cd ~
#         return
#     else if test -d $argv[1]
#         cd $argv[1]
#     else
#         # fallback to zoxide
#         if z $argv
#             printf "\U000F17A9 " # folder icon (nerd font)
#             pwd
#         else
#             echo "Error: Directory not found"
#         end
#     end
# end

# alias cd='zd'

# --- Open with xdg-open ---
function open
    xdg-open $argv >/dev/null 2>&1 &
end

# ---------------------------
# 📂 Directory Shortcuts
# ---------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias hyprr='cd /home/ihzabaker/Projects/myhyprland/dotfiles/.config/hypr'
alias editfishalias='n ~/.config/fish/conf.d/aliases.fish'

# ---------------------------
# 🧰 Tools
# ---------------------------

alias d='docker'
alias r='rails'

# --- nvim helper ---
function n
    if test (count $argv) -eq 0
        nvim .
    else
        nvim $argv
    end
end

# ---------------------------
# 🧩 Git Shortcuts
# ---------------------------

alias g='git'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'

# Docker / Node / Laravel
alias dps='docker ps'
alias dstop='docker stop (docker ps -q)'
alias drm='docker rm (docker ps -aq)'
alias drmi='docker rmi (docker images -q)'
alias artisan='php artisan'
alias nrd='npm run dev'
alias nrb='npm run build'
alias nrs='npm run start'

# Create a new Laravel project
alias laravel-new='composer create-project laravel/laravel'

# Run migrations
alias laravel-migrate='php artisan migrate'

# Rollback migrations
alias laravel-rollback='php artisan migrate:rollback'

# Run seeders
alias laravel-seed='php artisan db:seed'

# Clear cache
alias laravel-cache-clear='php artisan cache:clear'

# Clear config cache
alias laravel-config-clear='php artisan config:clear'

# Check Laravel version
alias laravel-version='php artisan --version'

# live development laravel
alias crd='composer run dev'

# Quality of Life
alias please='sudo $(history | tail -n1 | string split -f2 " ")'
alias reload.fish='source ~/.config/fish/config.fish'
alias weather='curl wttr.in'
alias c='clear && printf "\e[3J"'
alias about='fastfetch'

# hyprland things
alias checkclass='hyprctl clients'
alias matugen='cd /home/ihzabaker/Projects/myhyprland/dotfiles/.config/hypr/scripts/ & ./set-theme.sh'

# power profile
alias save='powerprofilesctl set power-saver'
alias balance='powerprofilesctl set balanced'
alias perf='powerprofilesctl set performance'
alias getmode='powerprofilesctl get'

# Check current GTK theme
alias gtk-theme="grep -E 'gtk-theme-name' ~/.config/gtk-3.0/settings.ini ~/.config/gtk-4.0/settings.ini | awk -F'=' '{print \$2}'"
alias getgtktheme='gsettings get org.gnome.desktop.interface gtk-theme'
# Check current icon theme
alias icon-theme="grep -E 'gtk-icon-theme-name' ~/.config/gtk-3.0/settings.ini ~/.config/gtk-4.0/settings.ini | awk -F'=' '{print \$2}'"

# Check current color scheme
alias gtk-colorscheme="grep -E 'gtk-application-prefer-dark-theme' ~/.config/gtk-3.0/settings.ini ~/.config/gtk-4.0/settings.ini | awk -F'=' '{print \$2}'"

# arch helper

# Check pacman version
alias pac-version='pacman -V'

# Update system
alias update='sudo pacman -Syu'

# Install package
alias install='sudo pacman -S'

# Remove package
alias remove='sudo pacman -Rns'

# Search for package
alias search='pacman -Ss'

# List explicitly installed packages
alias listpkgs='pacman -Qe'

# Check for outdated packages
alias outdated='pacman -Qu'

# Info about a package
alias pkginfo='pacman -Qi'

# Clean cache
alias clean='sudo pacman -Sc'

# waydroid things
alias android='waydroid show-full-ui'
alias android.off='waydroid session stop'

# restart kitty 
alias res.kitty='killall -SIGUSR1 kitty'

alias restart.network='systemctl restart NetworkManager'

alias f='yazi'

alias themes=' cd ~/.config/omarchy/themes'

alias ser='php artisan ser'

alias start='npm run dev'

alias migrate-fresh-seed='php artisan migrate:fresh --seed'
