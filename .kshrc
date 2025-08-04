failsafe=1
export FPATH=$HOME/kshFun
autoload man
export LESS="-rIs"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
istrans=1
trap 'istrans=; echo' SIGINT
builtin grep
# sorts out the time variable, the i variable used in PS2 and the transient prompt
trap '[[ ${istrans:-u} = u  ]] || t="$(date +%s)"; [[ $istrans = 0 && $TERM != dumb ]] && { tput cuu $((`fc -lnN0 | sed "s/[[:blank:]]//" | wc -l`+1)); tput ed; print -n "\E[92m\E[7m$PWD_TRUNC\E[27m-%\E[0m "; fc -lnN0 | sed "s/[[:blank:]]//"; istrans=; }; failsafe=0' DEBUG
export FCEDIT=micro
for FILE in ~/kshScripts/*; do
    . $FILE
done
[[ $onetime = 1 ]] || {
    for FILE in ~/kshOneTime/*; do
        . $FILE
    done
}
onetime=1
printf "Welcome to the Korn shell!\nEnjoy your stay :3\n"
#---aliases for git---#
alias gc="git commit -a"
alias git="hub"
alias gl="git log --oneline --all --graph --decorate"
alias gf="git pull"
alias gp="git push"
alias gco="git checkout"
alias gs="git stash"
alias gsd="git stash drop"
alias gd="git diff"
alias gr="git reset"
alias ga="git add"
#---general aliases---#
alias ls="ls --color=auto"
alias la="ls -lhA"
alias viksh="vim ~/.kshrc; print -n"
alias ce="clear; . ~/.kshrc"
alias nerdfetch="nerdfetch -c"
alias cbl="cbonsai -l"
alias shit="fuck -y"
# alias whatbroke="sudo systemctl list-units --failed"
alias huh="echo yeah..."
alias mkexec="chmod +x"
alias visudo="doas vim /etc/doas.conf"
alias rr="rm -r"
alias eshell="emacs -nw --no-splash -f eshell"
alias update="doas xbps-install -Su && flatpak update && brew upgrade"
alias scug='echo "(\_/)" && echo "|OxO|" && echo "(___)"'
alias birth="stat --format=%w / | cut -b -10"
alias sudo="doas "
alias doas="doas "
alias sftrbt="pkill xinit"
alias wtf="netbsd-wtf"
alias wttr="curl wttr.in/?format=1 2>/dev/null | sed 's/   / /'"
alias clean="doas xbps-remove -Oof; doas vkpurge rm all"
alias tkill="pkill -9 -t"
alias petpet='printf "purrr"; for i in {3..$(shuf -i 3-30 | head -1)}; do printf "r"; done; echo'
function crap {
    su -c "$(fc -p !!)" root
}
#---ideas taken from mcdutchie---#
function .sh.tilde.get {
    case ${.sh.tilde} in
	'~scripts') .sh.value=~/kshScripts ;;
	'~local') .sh.value=~/.local ;;
	'~trash') .sh.value=~/.local/share/Trash ;;
	'~conf') .sh.value=~/.config ;;
	'~ssh') .sh.value=~/.ssh ;;
	\~*) eval ".sh.value=${.sh.tilde}"; [[ ${.sh.value} == "${.sh.tilde}" ]] ;;
    esac
}
function PS1.get {
    istrans=0
    i=0
    if [[ -v RPROMPT ]]; then
        typeset -R "$COLUMNS" rp=$RPROMPT
        .sh.value=$'\E[0m'${rp}$'\r'${PS1}
    fi
}
#---mcdutchie block ends here---#
function PS2.get {
    (( i++ ))
    .sh.value=$'\E[92m«\E[94m'$i$'\E[92m»\E[0m  '
}
