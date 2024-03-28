# * env vars
export WINIT_X11_SCALE_FACTOR=1
export EDITOR="emacsclient -cq"

# * aliases
alias la='ls -a'
alias ll='ls -lh'
alias lla='ls -alh'
alias mv='mv -i'
alias rm='rm -I'
#alias vifm='~/.config/vifm/scripts/vifmrun'

alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

# * vi settings
if test $TERM = "eat-truecolor"
    # special emacs-vterm config
    fish_default_key_bindings
    set fish_cursor_default line
else
    # all other terminal emulators
    fish_vi_key_bindings
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
end

# * autostart
neofetch
