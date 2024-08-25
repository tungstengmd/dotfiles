set DISPLAY :0.0
set BUN_INSTALL "$HOME/.bun"
set PATH $BUN_INSTALL/bin:$PATH
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
starship init fish | source
zoxide init fish | source
atuin init fish | source
thefuck --alias | source
alias ce="clear && exec fish"
alias gc="git commit -a"
alias cave="/mnt/c/winscap.exe 2 48000 16 > /tmp/cava.fifo & cava"
alias cd="z"
alias git="hub"
alias gl="git log --oneline --all --graph --decorate $argv"
alias gf="git pull"
alias gp="git push"
alias ls="eza"
