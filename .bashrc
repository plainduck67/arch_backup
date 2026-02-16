#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

fastfetch
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1="\[\e[38;2;136;192;208m\]\u@\h \[\e[38;2;216;222;233m\]\w❯ \[\e[0m\]"



