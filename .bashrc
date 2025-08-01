# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1="[`[ $USER = root ] && echo '\[\033[91m\]' || echo '\[\033[92m\]'`\u\[\033[93m\]@\[\033[92m\]\h \[\033[93m\]in \[\033[38;5;245m\]\w\[\033[0m\]] `[ $USER = root ] && echo '#' || echo '%'` " 
