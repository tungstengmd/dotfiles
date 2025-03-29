#!/bin/ksh
alias xr="doas xbps-remove -Rf"
alias clean="doas xbps-remove -Oof"
alias isthere="xbps-query -Rs"
alias lookfor="xbps-query -l | rg"
