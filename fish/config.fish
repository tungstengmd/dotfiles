starship init fish | source
zoxide init fish | source
atuin init fish | source
thefuck --alias | source
if not set -q ZELLIJ                                                                                                                                                           
    if test "$ZELLIJ_AUTO_ATTACH" = "true"                                                                                                                                     
        zellij attach -c                                                                                                                                                       
    else                                                                                                                                                                       
        zellij                                                                                                                                                                 
    end                                                                                                                                                                        
                                                                                                                                                                               
    if test "$ZELLIJ_AUTO_EXIT" = "true"                                                                                                                                       
        kill $fish_pid                                                                                                                                                         
    end                                                                                                                                                                        
end
alias ce="clear && exec bash"
alias gc="git commit -a"
alias cave="/mnt/c/winscap.exe 2 48000 16 > /tmp/cava.fifo & cava"
alias ll="ls -la --color=auto"
alias cd="z"
