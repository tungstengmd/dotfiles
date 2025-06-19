eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
istrans=
trap 'istrans=; echo' SIGINT
trap '[[ $istrans = 0 ]] && { tput cuu 2; tput ed; print -n "\E[92m\E[7m$(pwd | sed "s|^$HOME|~|")\E[27m-%\E[0m "; fc -lnN0 | sed "s/^[ \t]*//"; istrans=1; }; [[ ${istrans:-u} != "u" ]] && t="$(date +%s)"' DEBUG
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools:$HOME/.cargo/bin:$HOME/venv/bin
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
alias petpet='printf "purrr"; for (( i=3; i<$(shuf -i 3-30 | head -1); i++ )); do printf "r"; done; echo'
function crap {
    su -c "$(hist -p !!)" root
}
function man {
    [[ "$(echo exit | ${@:$#} --nroff 2>/dev/null)" = *"TH"* ]] && "${@:$#}" --nroff 2>&1 | env man -la || env man "$@"
}
#---ideas taken from mcdutchie---#
function .sh.tilde.get {
    case ${.sh.tilde} in
	'~scripts') .sh.value=~/kshScripts ;;
	'~local') echo "~local - a tilde expansion to ~/.local"; .sh.value=~/.local ;;
	'~trash') echo "~trash - the trash bin used by most xdg-compliant software, just not rm !"; .sh.value=~/.local/share/Trash ;;
	'~conf') echo "~conf - a tilde expansion to .config, which is where your configuration should be"; .sh.value=~/.config ;;
	'~ssh') echo "~ssh - the ssh folder in which your keys are stored, as well as other ssh data"; .sh.value=~/.ssh ;;
	\~*) eval ".sh.value=${.sh.tilde}"; [[ ${.sh.value} == "${.sh.tilde}" ]] && echo 'WARNING: unknown expansion' >&2 ;;
    esac
}
function PS1.get {
    istrans=0
    if [[ -v RPROMPT ]]; then
        typeset -R "$COLUMNS" rp=$RPROMPT
        .sh.value='[0m'${rp//[$\`]/\\\0}$'\r'${PS1}
    fi
}
#---mcdutchie block ends here---#
typeset -A Keytable
trap 'istrans=1; eval "${Keytable[${.sh.edchar}]}"' KEYBD
unset -f keybind
function keybind # key [action]
{
    typeset key=$(print -f "%q" "$2")
    case $# in
        2)
        Keytable[$1]=' .sh.edchar=${.sh.edmode}'"$key"
        ;;
        1) unset Keytable[$1]
        ;;
        *) print -u2 "Usage: $0 key [action]"
        return 2 # usage errors return 2 by default
    esac
}
