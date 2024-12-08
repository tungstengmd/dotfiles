cd
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
starship init fish | source
zoxide init fish | source
atuin init fish | source
thefuck --alias | source
wal -R > meow.txt
rm meow.txt
#---Git aliases---#
alias gc="git commit -a"
alias git="hub"
alias gl="git log --oneline --all --graph --decorate $argv"
alias gf="git pull"
alias gp="git push"
alias gco="git checkout"
alias gs="git stash"
alias gd="git diff"
#---General aliases---#
alias ls="eza -a"
alias man="batman $argv"
alias vifish="vi ~/.config/fish/config.fish"
alias vifoot="vi ~/.config/foot/foot.ini"
alias yeet="yay -Rcns"
alias ce="clear && exec fish"
# alias cave="/mnt/c/winscap.exe 2 48000 16 > /tmp/cava.fifo & cava" #
alias cd="z"
alias nerdfetch="nerdfetch -c" # comment out if you don't use cozette
alias cbl="cbonsai -l"
alias shit="fuck -y"
alias whatbroke="sudo systemctl list-units --failed"
alias huh="echo yeah..."
