# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\[\e[92m\]\u\[\e[93m\]@\[\e[92m\]\h \[\e[0m\]in \[\e[38;5;242m\]\W\[\e[0m\]]\$ '

eval "$(thefuck --alias)"
