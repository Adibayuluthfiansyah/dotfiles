# ~/.config/fish/config.fish

# --- mise ---
if type -q mise
    mise activate fish | source
end

# --- starship ---
# if type -q starship
#     starship init fish | source
# end

# --- zoxide ---
if type -q zoxide
    zoxide init fish | source
end

# --- fzf ---
if type -q fzf
    if test -f /usr/share/fzf/key-bindings.fish
        source /usr/share/fzf/key-bindings.fish
    end

    if test -f /usr/share/fzf/completion.fish
        source /usr/share/fzf/completion.fish
    end
end

# --- opencode ---
set -g -a fish_user_paths "$HOME/.opencode/bin"

# --- fastfetch (Tampilkan spek saat buka terminal) ---
if status is-interactive && type -q fastfetch && not set -q FASTFETCH_SHOWN
    set -gx FASTFETCH_SHOWN 1
    set -l colors red green blue yellow cyan magenta white
    set -l c (random choice $colors)
    clear
    echo "" 
    fastfetch \
        --logo arch \
        --logo-color-1 $c \
        --logo-color-2 $c \
        --separator " ➜  " \
        --color-keys $c \
        --color-title $c \
        --structure title:os:kernel:shell:wm:terminal:cpu:gpu:memory:disk:packages:uptime
    #  Tambahkan garis bawah tipis untuk pemisah
    # set_color $c; echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"; set_color normal
end



# --- oh-my-posh ---
if type -q oh-my-posh
    oh-my-posh init fish --config ~/.poshthemes/sonicboom_dark.omp.json | source
end


# --- Sonar Scanner ---
set -x SONAR_SCANNER_HOME /opt/sonar-scanner
set -x PATH $SONAR_SCANNER_HOME/bin $PATH