PS1='$([ $? = 0 ] && e="\n\033[92m╰──" || e=" «\033[91m"$?"/SIG`kill -l "$?"`\033[92m»\033[0m\n\033[91mx  " 
brnch="$(echo "$(git branch --show-current 2>/dev/null)")"
[ "$brnch" = "" ] || brnch="$(echo " ($brnch)")"
case `git status 2>&1` in
    *"has diverged"*) symb+="%" ;&
    *"branch is behind"*) symb+="<" ;&
    *"ahead of"*) symb+=">" ;;&
    *"new file:"*) symb+="A" ;;&
    *"deleted"*) symb+="D" ;;&
    *"renamed"*) symb+="R" ;;&
    *"Untracked"*) symb+="U" ;;&
    *"modified"*) symb+="M" ;;&
    *"detached"*) brnch="$(git branch | head -1 | sed "s/)//")"; brnch=" (${brnch##* })" ;;
    ?) symb=" "
esac
printf "\033[92m╭─{owo}─{`date +%H:%M`}`[ $USER = root ] && echo "\033[91m" || echo "\033[93m"` ${USER} \033[92min \033[30m\033[102m`pwd | sed -e "s|^$HOME|~|" -e "s|\(\.\{0,1\}[^/]\)[^/]*/|\1/|g"`\033[49m\033[92m$brnch`[ "$symb" = "" ] && echo " " || echo " [$symb] "`took $(($(date +%s) - $t))s$e%% \033[0m")'
