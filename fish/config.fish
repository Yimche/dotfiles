source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
    printf %s\n ""
    fastfetch
    #smth smth
end

fish_vi_key_bindings

alias webcam='mpv av://v4l2:/dev/video0 --profile=low-latency --untimed'
alias irc='ssh ircj@akropolis.trickypr.com'
alias lf='lfcd'
alias fd='fd -H -i'
alias vim='nvim'
alias nps='cat /sys/bus/pci/devices/0000:00:01.0/power_state'
alias vm='kitty +kitten ssh comp2700-lab'

starship init fish | source
zoxide init fish | source

set -gx LS_COLORS (vivid generate catppuccin-mocha)

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
set -gx PATH $HOME/.cabal/bin /home/julian/.ghcup/bin $PATH # ghcup-env

fish_add_path /home/julian/.spicetify