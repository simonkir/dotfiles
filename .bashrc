# * init
PS1='[\u@\h \W]\$ '
[[ $- != *i* ]] && return

# * env vars
export EDITOR="emacsclient -tq"
export VISUAL="emacsclient -cq"

# * settings
bind "set completion-ignore-case on" #ignore upper and lowercase when TAB completion
shopt -s expand_aliases
shopt -s histappend
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s autocd # change to named directory
shopt -s checkwinsize # update window size after each cmd if necessary

HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with space in the history.

# * aliases
alias ls='ls --color=auto'
alias la="ls -a"
alias ll="ls -lh"
alias lla="ls -alh"
alias mv="mv -i"
alias rm="rm -I"

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias ......="cd ../../../../../"
