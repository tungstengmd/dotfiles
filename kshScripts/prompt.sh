PS1='$(exitcolor=$([ $? = 0 ] && echo "\033[92m╰──" || echo "\033[91mx  ")
[[ $t != "" ]] && t="took $(dc -e ""$(date +%s)" ${t} - p")s"
gitstat="$(git status 2>&1)"
symb=''
case $gitstat in
    *"has diverged"*) symb+="%" ;&
    *"branch is behind"*) symb+="<" ;& 
    *"ahead of"*) symb+=">" ;&
    *"new file:"*) symb+="A" ;&
    *"deleted:"*) symb+="D" ;&
    *"renamed"*) symb+="R" ;&
    *"Untracked"*) symb+="U" ;&
esac
printf "\033[92m╭─{owo}─{"$(date +%H):$(date +%M)"}$([ $USER = root ] && echo "\033[91m" || echo "\033[93m") ${USER} \033[92min \033[30m\033[102m$(pwd | sed "s|$HOME|~|")\033[49m\033[92m $([ "$(git status >/dev/null 2>&1; echo $?)" = 0 ] && echo "($(git branch --show-current))") $([ "$symb" = "" ] || echo "[$symb] ")\n${exitcolor}> \033[0m"
)'
