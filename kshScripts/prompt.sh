PS1='$(e=$?
[ $e = 0 ] && { exc="\033[92m╰──"; e=""; } || { exc="\033[91mx  "; e="«\033[91m"$e"/SIG$(kill -l "$e")\033[92m»\033[0m"; }
[[ $t != "" ]] && t="took $(($(date +%s) - ${t}))s"
gitstat="$(git status 2>&1)"
symb=""
brnch="$(echo "$(git branch --show-current 2>/dev/null)")"
[ "$brnch" = "" ] || brnch="$(echo " ($brnch)")"
case $gitstat in
    *"has diverged"*) symb+="%" ;&
    *"branch is behind"*) symb+="<" ;&
    *"ahead of"*) symb+=">" ;;&
    *"new file:"*) symb+="A" ;;&
    *"deleted"*) symb+="D" ;;&
    *"renamed"*) symb+="R" ;;&
    *"Untracked"*) symb+="U" ;;&
    *"modified"*) symb+="M" ;&
    *"detached"*) brnch="$(git branch | head -1 | sed "s/)//")"; brnch=" (${brnch##* })"
esac
printf "\033[92m╭─{owo}─{"$(date +%H:%M)"}$([ $USER = root ] && echo "\033[91m" || echo "\033[93m") ${USER} \033[92min \033[30m\033[102m$(pwd | sed -e "s|^$HOME|~|" -e "s|\(\.\{0,1\}[^/]\)[^/]*/|\1/|g")\033[49m\033[92m$brnch $([ "$symb" = "" ] || echo "[$symb] ")$t $e\n${exc}%% \033[0m")'
