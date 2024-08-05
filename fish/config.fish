starship init fish | source
zoxide init fish | source
if status is-interactive
    # Commands to run in interactive sessions can go here
end
alias ce="clear && exec bash"
starship init fish | source
thefuck --alias | source
alias nvchad="NVIM_APPNAME=nvchad nvim"
alias gc="git commit -a"
alias cave="/mnt/c/winscap.exe 2 48000 16 > /tmp/cava.fifo & cava"