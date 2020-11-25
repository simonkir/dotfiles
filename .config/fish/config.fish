export EDITOR='nvim'

# aliases
alias ll='ls -lh'
alias lla='ls -alh'
alias mv='mv -i'
alias rm='rm -I'
alias vifm='~/.config/vifm/scripts/vifmrun'
alias git-dtf='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias doom='~/.emacs.d/bin/doom'

alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

fish_vi_key_bindings

# cursor style settings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore

neofetch

# vim:ft=bash
