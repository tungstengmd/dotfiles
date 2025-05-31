trap 'echo' SIGINT
trap 't="$(date +%s)"' DEBUG
export DOTNET_ROOT=$HOME/.dotnet
export PLAN9=$HOME/plan9port
export PATH=$PATH:$PLAN9/bin:$DOTNET_ROOT:$DOTNET_ROOT/tools:$HOME/.cargo/bin:$HOME/venv/bin
export FCEDIT=micro
eval "$(thefuck --alias)"
for FILE in ~/kshScripts/*; do
    . $FILE
done
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
alias gr="git reset --hard HEAD"
#---general aliases---#
alias ls="ls --color=auto"
alias la="ls -lhA"
alias viksh="vim ~/.kshrc"
alias ce="clear; . ~/.kshrc"
alias nerdfetch="nerdfetch -c"
alias cbl="cbonsai -l"
alias shit="fuck -y"
# alias whatbroke="sudo systemctl list-units --failed"
alias huh="echo yeah..."
alias mkexec="chmod +x"
alias visudo="doas vim /etc/doas.conf"
alias rr="rm -rf"
alias eshell="emacs -nw --no-splash -f eshell"
alias update="doas xbps-install -Su && flatpak update && brew upgrade"
alias scug='echo "(\_/)" && echo "|OxO|" && echo "(___)"'
alias birth="stat --format=%w / | cut -b -10"
alias sudo="doas "
alias rm="gomi"
alias doas="doas "
alias sftrbt="pkill xinit"
alias wtf="netbsd-wtf"
alias wttr="curl wttr.in/?format=1 2>/dev/null | sed 's/   / /'"
alias clean="doas xbps-remove -Oof; doas vkpurge rm all"
alias tkill="pkill -9 -t"
alias petpet='printf "purrr"; for (( i=3; i<$(shuf -i 3-30 | head -1); i++ )); do printf "r"; done; echo'
function crap {
    su -c "$(history -p !!)" root
}
function man {
    [ "$#" -gt 1 ] && env man "$@"
    case "$(type $@ 2>/dev/null)" in
	*"builtin"*) "$@" --nroff | env man -la ;;
	*) [ "$("${@:$#}" --nroff 2>&1 >/dev/null; echo $?)" = 0 ] && "$@" --nroff | env man -la || env man "$@"
    esac
}
function .sh.tilde.get {
    case ${.sh.tilde} in
	'~scripts') .sh.value=~/kshScripts ;;
	'~local') .sh.value=~/.local ;;
	'~trash') .sh.value=~/.local/share/Trash ;;
	'~conf') .sh.value=~/.config ;;
	\~*) .sh.value=~ ;;
    esac
}
