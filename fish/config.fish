starship init fish | source
zoxide init fish | source
atuin init fish | source
thefuck --alias | source
if status is-interactive
    # Commands to run in interactive sessions can go here
end
alias ce="clear && exec bash"
alias nvchad="NVIM_APPNAME=nvchad nvim"
alias gc="git commit -a"
alias cave="/mnt/c/winscap.exe 2 48000 16 > /tmp/cava.fifo & cava"
alias ll="ls -la --color=auto"
alias cd="z"