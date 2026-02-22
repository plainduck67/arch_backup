#
# ~/.bashrc
#

# If not running interactively, don't do anything
fastfetch
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[1;36m\][\u@\h \W]\$ \[\e[0m\]'
