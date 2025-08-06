failsafe=1
export FPATH=$HOME/.kshrc.d/fun
autoload man
export LESS="-rIs"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
istrans=1
trap 'istrans=; echo' SIGINT
builtin grep
# sorts out the time variable, the i variable used in PS2 and the transient prompt
trap '[[ ${istrans:-u} = u  ]] || t="$(date +%s)"; [[ $istrans = 0 && $TERM != dumb ]] && { tput cuu $((`fc -lnN0 | sed "s/[[:blank:]]//" | wc -l`+1)); tput ed; print -n "\E[92m\E[7m$PWD_TRUNC\E[27m-%\E[0m "; fc -lnN0 | sed "s/[[:blank:]]//"; istrans=; }; failsafe=0' DEBUG
export FCEDIT=micro
for FILE in ~/.kshrc.d/scripts/*; do
    . $FILE
done
[[ $onetime = 1 ]] || {
    for FILE in ~/.kshrc.d/onetime/*; do
        . $FILE
    done
}
onetime=1
printf "Welcome to the Korn shell!\nEnjoy your stay :3\n"
function crap {
    su -c "$(fc -p !!)" root
}
#---ideas taken from mcdutchie---#
function .sh.tilde.get {
    case ${.sh.tilde} in
	'~scripts') .sh.value=~/.kshrc.d/scripts ;;
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
