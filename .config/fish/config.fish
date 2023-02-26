# env setup ################################################################

export WINIT_X11_SCALE_FACTOR=1

function vterm_printf;
    if begin; [  -n "$TMUX" ]  ; and  string match -q -r "screen|tmux" "$TERM"; end
        # tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
    else if string match -q -- "screen*" "$TERM"
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$argv"
    else
        printf "\e]%s\e\\" "$argv"
    end
end



# misc vars ################################################################

export EDITOR="emacsclient -cq"



# aliases ##################################################################

alias ll='ls -lh'
alias lla='ls -alh'
alias mv='mv -i'
alias rm='rm -I'
#alias vifm='~/.config/vifm/scripts/vifmrun'

alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'



# vi settings ##############################################################

if test $TERM = "xterm-256color"
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



# autostart ################################################################

neofetch

# vim:ft=bash
