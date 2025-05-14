source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    printf %s\n ""
#    fastfetch
#end

fish_vi_key_bindings
alias diff='diff -W $(tput cols) --color=always'
alias irc='ssh ircj@akropolis.trickypr.com'
alias lf='lfcd'
alias fd='fd -H -i'
alias nps='cat /sys/bus/pci/devices/0000:00:01.0/power_state'
alias vim='nvim'
alias hx='helix'
alias webcam='mpv av://v4l2:/dev/video0 --profile=low-latency --untimed'
alias objdump='objdump --disassembler-color=colour'

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

# Remove first new line
function starship_transient_prompt_func
    tput cuu1
    starship module character
end

function prompt_newline --on-event fish_postexec
    echo
end

alias clear "command clear; commandline -f clear-screen"

starship init fish | source
zoxide init fish | source

# set -gx LS_COLORS (vivid generate catppuccin-macchiato)

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
set -gx PATH /home/julian/.cabal/bin /home/julian/.ghcup/bin $PATH # ghcup-env

set -gx PATH /home/julian/.jdks/openjdk-23.0.2/bin/ $PATH

set -gx PATH /home/julian/.spicetify $PATH
