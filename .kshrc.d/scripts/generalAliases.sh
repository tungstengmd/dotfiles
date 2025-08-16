alias ls="ls -A --color=auto"
alias la="ls -lhA"
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
alias prompt="prompt; print"
function viksh {
    file=$(FZF_DEFAULT_COMMAND="ls ~/.kshrc ~/.kshrc.d/**/*" fzf --tac --preview "bat -l bash {}")
    [[ $file = "" ]] || vim $file
}
