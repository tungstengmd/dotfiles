starship init fish | source
zoxide init fish | source
if status is-interactive
    # Commands to run in interactive sessions can go here
end
alias ce="clear && exec bash"
starship init fish | source
thefuck --alias | source
