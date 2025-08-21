failsafe=1
PS1_MIN=0
set -H
export FPATH=$HOME/.kshrc.d/fun
autoload man
export LESS="-rIs"
istrans=1
trap 'istrans=; print' SIGINT
builtin grep egrep fgrep date cat mv rm rmdir uniq ln uname wc
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
#---mcdutchie block ends here---#
