# The default config record. This is where much of your global configuration is setup.
$env.config = {
  show_banner: false # true or false to enable or disable the welcome banner at startup
  ls: {
    use_ls_colors: true # use the LS_COLORS environment variable to colorize output
    clickable_links: true # enable or disable clickable links. Your terminal has to support links.
  }
  rm: {
    always_trash: false # always act as if -t was given. Can be overridden with -p
  }
  #cd: {
  #  abbreviations: false # allows `cd s/o/f` to expand to `cd some/other/folder`
  #}
  table: {
    mode: light # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
    index_mode: always # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
    show_empty: true # show 'empty list' and 'empty record' placeholders for command output
    trim: {
      methodology: wrapping # wrapping or truncating
      wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
      truncating_suffix: "..." # A suffix used by the 'truncating' methodology
    }
  }

  # datetime_format determines what a datetime rendered in the shell would look like.
  # Behavior without this configuration point will be to "humanize" the datetime display,
  # showing something like "a day ago."

  datetime_format: {
    normal: '%a, %d %b %Y %H:%M:%S %z'  # shows up in displays of variables or other datetime's outside of tables
    # table: '%m/%d/%y %I:%M:%S%p'        # generally shows up in tabular outputs such as ls. commenting this out will change it to the default human readable datetime format
  }
}

source ~/.config/nushell/zoxide.nu
source ~/.config/nushell/starship.nu

alias t = todo.sh
alias mpv = devour mpv
alias sxiv = devour sxiv
alias zathura = devour zathura
alias scrcpy = devour scrcpy
#alias ls = exa --long --group-directories-first --icons
#alias ll = exa --long --group-directories-first --icons
#alias la = exa --long --all --group-directories-first --icons
#alias lt = exa --long --tree --group-directories-first --icons
alias webcam = mpv av://v4l2:/dev/video0 --profile=low-latency --untimed
alias emacs = emacsclient -c -a "emacs"
alias adb-sync = ^$'($env.HOME)/code_Master/better-adb-sync/src/adbsync.py'
alias adb-monitor = ^$'(env.HOME)/code_Master/scripts/adb-monitor.sh'
#alias hx = helix
alias vim = nvim
alias cd = z
alias yy = yazi

# Custom launch scrcipt
def launch [$f] {
  ^$'($env.HOME)/code_Master/scripts/launch.sh' $f
}
