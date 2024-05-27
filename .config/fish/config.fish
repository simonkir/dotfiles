# * env vars
set -gx WINIT_X11_SCALE_FACTOR 1
set -gx EDITOR "emacsclient -cq"

# * aliases
abbr -a "la" "ls -a"
abbr -a "ll" "ls -lh"
abbr -a "lla" "ls -lha"
abbr -a "mv" "mv -i"
abbr -a "rm" "rm -I"
abbr -a "gspdf" "gs -q -dNOPAUSE -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook"
#abbr -a "vifm" "~/.config/vifm/scripts/vifmrun"

function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

# * keybinds
function fish_hybrid_key_bindings --description \
"Vi-style bindings that inherit emacs-style bindings in all modes"
    # copy emacs keybinds into each mode
    fish_default_key_bindings -M insert
    fish_default_key_bindings -M normal
    fish_default_key_bindings -M visual

    # make vi keybinds take precedence over emacs keybinds
    fish_vi_key_bindings --no-erase
end

if test $TERM = "eat-truecolor"
    set -g fish_key_bindings fish_default_key_bindings
    set fish_cursor_default line
else
    set -g fish_key_bindings fish_hybrid_key_bindings
    set fish_cursor_insert line
    set fish_cursor_replace underscore
    set fish_cursor_replace_one underscore
end

# * visuals
fish_config prompt choose scales
fish_config theme choose Dracula

function fish_greeting
    neofetch
end
