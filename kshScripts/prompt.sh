function RPROMPT.get {
    [[ -n ${SSH_CLIENT} ]] && { .sh.value="$(who am i | tr -d '()' | awk '{print $5}')"; [[ $t = "" ]] || .sh.value+=", "; }
    .sh.value+="took $(($(date +%s) - $t))s"
}
PS1='$([ $? = 0 ] && e="\n\E[92m╰──" || e="«\E[91m"$?"/SIG`kill -l "$?"`\E[92m»\E[0;91m\nx  " 
brnch="$(git branch --show-current 2>/dev/null)"
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
print -n "\E[0;92m╭─{owo}─{`date +%H:%M`}`[ $USER = root ] && echo "\E[91m" || echo "\E[93m"` ${USER} \E[92min \E[7m`pwd | sed -e "s|^$HOME|~|" -e "s|\(\.\{0,1\}[^/]\)[^/]*/|\1/|g"`\E[27m$brnch`[ "$symb" = "" ] && echo " " || echo " [$symb] "`$e% \E[0m")'
