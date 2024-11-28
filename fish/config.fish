eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
starship init fish | source
zoxide init fish | source
atuin init fish | source
thefuck --alias | source
#---Git aliases---#
alias gc="git commit -a"
alias git="hub"
alias gl="git log --oneline --all --graph --decorate $argv"
alias gf="git pull"
alias gp="git push"
alias gco="git checkout"
#---General aliases---#
alias ls="eza"
alias man="batman $argv"
alias vifish="vi ~/.config/fish/config.fish"
alias yeet="yay -Rcns"
alias ce="clear && exec fish"
alias cave="/mnt/c/winscap.exe 2 48000 16 > /tmp/cava.fifo & cava"
alias cd="z"
