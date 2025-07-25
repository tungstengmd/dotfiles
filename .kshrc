failsafe=1
export FPATH=$HOME/kshFun
autoload man
export LESS="-rIs"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
istrans=1
trap 'istrans=; echo' SIGINT
# sorts out the time variable, the i variable used in PS2 and the transient prompt
trap 'i=0; [[ ${istrans:-u} = u  ]] || t="$(date +%s)"; [[ $istrans = 0 && $TERM != dumb ]] && { tput cuu $((`fc -lnN0 | sed "s/[[:blank:]]//" | wc -l`+1)); tput ed; print -n "\E[92m\E[7m$PWD_TRUNC\E[27m-%\E[0m "; fc -lnN0 | sed "s/^[ \t]*//"; print "\E[A"; istrans=; }; failsafe=0' DEBUG || failsafe=1
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
alias petpet='printf "purrr"; for i in {3..$(shuf -i 3-30 | head -1)}; do printf "r"; done; echo'
function crap {
    su -c "$(hist -p !!)" root
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
    tput cuu 1
}
function PS1.get {
    istrans=0
    if [[ -v RPROMPT ]]; then
        typeset -R "$COLUMNS" rp=$RPROMPT
        .sh.value='[0m'${rp}$'\r'${PS1}
    fi
}
#---mcdutchie block ends here---#
function PS2.get {
    (( i++ ))
    .sh.value="[4m${i}[0m  "
}
