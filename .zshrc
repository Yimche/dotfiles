#
# ~/.zshrc
#

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

# End of lines added by compinstall
source $HOME/code_Master/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/code_Master/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $HOME/code_Master/zsh-autosuggestions/zsh-autosuggestions.zsh

# Haskell Stuff
export PATH="$HOME/.cabal/bin:$PATH"
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.local/bin/:$PATH"

#: Alias
#: alias lf='lfrun'
#alias open='devour xdg-open'
#alias t='todo.sh'
#alias mpv='devour mpv'
#alias sxiv='devour sxiv'
#alias zathura='devour zathura'
#alias scrcpy='devour scrcpy'
alias ls='exa --long --group-directories-first --icons'
alias ll='exa --long --group-directories-first --icons'
alias la='exa --long --all --group-directories-first --icons'
alias lt='exa --long --tree --group-directories-first --icons'
#alias locate='updatedb --require-visibility 0 -o ~/.locate.db && locate --database=$HOME/.locate.db'
alias webcam='mpv av://v4l2:/dev/video0 --profile=low-latency --untimed'
#alias cdw='cd /mnt/c/Users/julia/'
alias irc='ssh ircj@akropolis.trickypr.com'
alias explorer='explorer.exe .'
alias vim='nvim'

#alias updatedb='updatedb --require-visibility 0 -o ~/.locate.db'

#: Functions
#: copy image with copyq 
ci() {
  ~/code_Master/scripts/copyq-img.sh $1
}

# lf change dir
LFCD="$HOME/.config/lf/lfcd.sh"
if [ -f "$LFCD" ]; then
  source "$LFCD"
  alias lf='lfcd'
fi

# Base16_Shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

print ""
fastfetch

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
export LS_COLORS="$(vivid generate nord)"
export EDITOR="nvim"
