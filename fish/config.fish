#source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    printf %s\n ""
#    fastfetch
#end

fish_vi_key_bindings

#alias diff='diff -W $(tput cols) --color=always'
#alias irc='ssh ircj@akropolis.trickypr.com'
#alias lf='lfcd'
#alias fd='fd -H -i'
#alias nps='cat /sys/bus/pci/devices/0000:00:01.0/power_state'
#alias vim='nvim'
#alias hx='helix'
#alias webcam='mpv av://v4l2:/dev/video0 --profile=low-latency --untimed'
#alias objdump='objdump --disassembler-color=colour'
#
### Useful aliases
## Replace ls with eza
#alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
#alias la='eza -a --color=always --group-directories-first --icons' # all files and dirs
#alias ll='eza -l --color=always --group-directories-first --icons' # long format
#alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
#alias l.="eza -a | grep -e '^\.'" # show only dotfiles
#
## Common use
#alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
#alias fixpacman="sudo rm /var/lib/pacman/db.lck"
#alias tarnow='tar -acf '
#alias untar='tar -zxvf '
#alias wget='wget -c '
#alias psmem='ps auxf | sort -nr -k 4'
#alias psmem10='ps auxf | sort -nr -k 4 | head -10'
#alias vdir='vdir --color=auto'
#alias grep='grep --color=auto'
#alias hw='hwinfo --short' # Hardware Info
#alias big="expac -H M '%m\t%n' | sort -h | nl" # Sort installed packages according to size in MB
#alias gitpkg='pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages
#alias update='sudo pacman -Syu'
#
## Get fastest mirrors
#alias mirror="sudo cachyos-rate-mirrors"
#
## Cleanup orphaned packages
#alias cleanup='sudo pacman -Rns (pacman -Qtdq)'
#
## Get the error messages from journalctl
#alias jctl="journalctl -p 3 -xb"
#
## Recent installed packages
#alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# Replaced aliases with functions

function diff
    command diff -W (tput cols) --color=always $argv
end

function irc
    ssh ircj@akropolis.trickypr.com $argv
end

function lf
    lfcd $argv
end

function fd
    command fd -H -i $argv
end

function nps
    cat /sys/bus/pci/devices/0000:00:01.0/power_state $argv
end

function vim
    nvim $argv
end

function hx
    helix $argv
end

function webcam
    mpv av://v4l2:/dev/video0 --profile=low-latency --untimed $argv
end

function objdump
    command objdump --disassembler-color=colour $argv
end

## Useful functions

# Replace ls with eza
function ls
    eza -al --color=always --group-directories-first --icons $argv
end

function la
    eza -a --color=always --group-directories-first --icons $argv
end

function ll
    eza -l --color=always --group-directories-first --icons $argv
end

function lt
    eza -aT --color=always --group-directories-first --icons $argv
end

function l.
    eza -a | grep -e '^\.' $argv
end

# Common use

function grubup
    sudo grub-mkconfig -o /boot/grub/grub.cfg $argv
end

function fixpacman
    sudo rm /var/lib/pacman/db.lck $argv
end

function tarnow
    tar -acf $argv
end

function untar
    tar -zxvf $argv
end

function wget
    command wget -c $argv
end

function psmem
    ps auxf | sort -nr -k 4 $argv
end

function psmem10
    ps auxf | sort -nr -k 4 | head -10 $argv
end

function vdir
    command vdir --color=auto $argv
end

function grep
    command grep --color=auto $argv
end

function hw
    hwinfo --short $argv
end

function big
    expac -H M '%m\t%n' | sort -h | nl $argv
end

function gitpkg
    pacman -Q | grep -i "\-git" | wc -l $argv
end

function update
    sudo pacman -Syu $argv
end

function mirror
    sudo cachyos-rate-mirrors $argv
end

function cleanup
    sudo pacman -Rns (pacman -Qtdq) $argv
end

function jctl
    journalctl -p 3 -xb $argv
end

function rip
    expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl $argv
end

# Existing functions

function vm
    qemu-system-x86_64 -enable-kvm -m 4G -smp 2 -nic user,hostfwd=tcp::5555-:22 ~/Documents/uni/Y3S1/3703/comp3703-2025.qcow2 &
    kitty +kitten ssh comp3703
    kill %1
end

function yy
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

function pyenv
    command pyenv init - | source
end

# Functions for !! and !$

function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Fish command history

function history
    builtin history --show-time='%F %T '
end

# Remove first new line

function starship_transient_prompt_func
    tput cuu1
    starship module character
end

function prompt_newline --on-event fish_postexec
    echo
end

function clear
    command clear
    commandline -f clear-screen
end

function vm
    qemu-system-x86_64 -enable-kvm -m 4G -smp 2 -nic user,hostfwd=tcp::5555-:22 ~/Documents/uni/Y3S1/3703/comp3703-2025.qcow2 &
    kitty +kitten ssh comp3703
    kill %1
end

function yy
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

function pyenv
    command pyenv init - | source
end

# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]

    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

# Remove first new line
function starship_transient_prompt_func
    tput cuu1
    starship module character
end

function prompt_newline --on-event fish_postexec
    echo
end

#alias clear "command clear; commandline -f clear-screen"

starship init fish | source
zoxide init fish | source
atuin init fish | source

#set -gx LS_COLORS (vivid generate catppuccin-macchiato)

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
set -gx PATH /home/julian/.jdks/openjdk-23.0.2/bin/ $PATH
set -gx PATH /home/julian/.spicetify $PATH
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
set -gx PATH $HOME/.cabal/bin /home/julian/.ghcup/bin $PATH # ghcup-env
