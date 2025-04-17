PS1='$(exitcolor=$([ $? = 0 ] && echo "\033[92m╰──" || echo "\033[91mx  ")
[[ $t != "" ]] && t="took $(($(date +%s) - ${t}))s"
gitstat="$(git status 2>&1)"
symb=''
[ "$(git status 2>&1; echo $?)" = 0 ] && brnch="$(echo "($(git branch --show-current))")"
case $gitstat in
    *"has diverged"*) symb+="%" ;&
    *"branch is behind"*) symb+="<" ;& 
    *"ahead of"*) symb+=">" ;&
    *"new file:"*) symb+="A" ;&
    *"deleted:"*) symb+="D" ;&
    *"renamed"*) symb+="R" ;&
    *"Untracked"*) symb+="U" ;&
    *"detached"*) brnch="$(git branch | head -1 | sed "s/)//")"; brnch="(${brnch##* })"
esac
printf "\033[92m╭─{owo}─{"$(date +%H):$(date +%M)"}$([ $USER = root ] && echo "\033[91m" || echo "\033[93m") ${USER} \033[92min \033[30m\033[102m$(pwd | sed -e "s|^$HOME|~|" -e "s|\(\.\{0,1\}[^/]\)[^/]*/|\1/|g")\033[49m\033[92m $brnch$([ "$symb" = "" ] || echo " [$symb] ")\n${exitcolor}\% \033[0m"
)'
