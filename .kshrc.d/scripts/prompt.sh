function PWD_TRUNC.get {
    .sh.value="`pwd | sed -e "s|$HOME|~|" -e "s|\(\.\{0,1\}[^/]\)[^/]*/|\1/|g"`"
}
function RPROMPT.get {
    #---check version for common tools or languages---#
    [[ -e `pwd`/package.json ]] && { `# go through all the runtimes`; { type node 2>&1 >/dev/null && .sh.value+=" `node -v`, "; } || { type deno 2>&1 >/dev/null && .sh.value+=" `deno -v | sed 's/deno /v/'`, "; } || { type bun 2>&1 >/dev/null && .sh.value+=" v`bun -v`, "; }; }
    [[ -e `pwd`/pyproject.toml ]] && type python 2>&1 >/dev/null && .sh.value+=" v`python -V | awk '{print $2}'`, "
    [[ -e `pwd`/Cargo.toml ]] && type rustc 2>&1 >/dev/null && .sh.value+=" v`rustc -V | awk '{print $2}'`, "
    [[ -e `pwd`/Gemfile* ]] && type ruby 2>&1 >/dev/null && .sh.value+=" v `ruby -v | awk '{print $2}'`, "
    [[ -e `pwd`/Package.swift ]] && type swift 2>&1 >/dev/null && .sh.value+=" v`swift -version | awk '{print $4}'`, "
    [[ -e `pwd`/go.mod ]] && type go 2>&1 >/dev/null && .sh.value+=" `go version | awk '{gsub("go", "v", $3); print $3}'`, "
    [[ -e `pwd`/artisan ]] && type php 2>&1 >/dev/null && .sh.value+=" v`php -v | awk '{print $2}'`, "
    [[ -e `pwd`/Dockerfile ]] || [[ -e `pwd`/.dockerignore ]] && { type docker 2&>1 >/dev/null && .sh.value+=" v`docker -v | awk '{print $3}'`, " || type podman 2>&1 >/dev/null && .sh.value+=" v`podman -v | awk '{print $3}'`, "; }
    [[ -e `pwd`/.cljfmt.edn ]] && type clj 2>&1 >/dev/null && .sh.value+=" v`clj --version | awk '{print $4}'`, "
    [[ -e `pwd`/tsconfig.json ]] && type tsc 2&>1 >/dev/null && .sh.value+=" v`tsc -v | awk '{print $4}'`, "
    [[ -e `pwd`/build.zig ]] && type zig 2>&1 >/dev/null && .sh.value+=" `zig version`, "
    #---now for the other stuff---#
    [[ -n ${SSH_CLIENT} ]] && { .sh.value+="$(who -m | tr -d '()' | awk '{print $5" ("$2")"}')"; [[ $t = "" ]] || .sh.value+=", "; } || .sh.value+="`tty | sed -e 's|/dev/||'`, "
    [[ -n $VIRTUAL_ENV || -n $PIPENV_ACTIVE || -n $CONDA_DEFAULT_ENV ]] && .sh.value+="venv active, "
    [[ $failsafe = 0 ]] && .sh.value+="took $(($(date -e) - $t))s" || .sh.value+="timeless"
    failsafe=1
}
function PS1.get {
    istrans=0
    i=0
    if [[ -v RPROMPT ]]; then
        typeset -R "$COLUMNS" rp=$RPROMPT
        .sh.value=$'\E[0m'${rp}$'\r'${PS1}
    fi
}
function PS2.get {
    (( i++ ))
    .sh.value=$'\E[92m«\E[94m'$i$'\E[92m»\E[0m  '
}
# sorts out the time variable, the i variable used in PS2 and the transient prompt
trap '[[ ${istrans:-u} = u  ]] || t="$(date -e)"; [[ $istrans = 0 && $TERM != dumb ]] && { tput cuu $((`fc -lnN0 | sed "s/[[:blank:]]//" | wc -l`+1)); tput ed; print -n "\E[92m\E[7m$PWD_TRUNC\E[27m-%\E[0m "; fc -lnN0 | sed "s/[[:blank:]]//"; istrans=; }; failsafe=0' DEBUG
PS1=$'$(e=$?
[ $e = 0 ] && { owo="\E[92mowo"; e="\n\E[92m╰──"; } || { owo="\E[91momo\E[92m"; e=" «\E[91m"$e"/SIG`kill -l "$e"`\E[92m»\E[0;91m\nx  "; } 
brnch="`git branch --show-current 2>/dev/null`"
[ "$brnch" = "" ] || brnch="`echo " ($brnch)"`"
case `git status 2>&1` in
    *"has diverged"*) symb+="%" ;;&
    *"branch is behind"*) symb+="<" ;;&
    *"ahead of"*) symb+=">" ;;&
    *"new file:"*) symb+="A" ;;&
    *"deleted"*) symb+="D" ;;&
    *"renamed"*) symb+="R" ;;&
    *"Untracked"*) symb+="U" ;;&
    *"modified"*) symb+="M" ;;&
    *"detached"*) brnch="`git branch | head -1 | sed "s/)//"`"; brnch=" (${brnch##* })" ;;
    ?) symb=
esac
print -n "\E[92m╭─{${owo}}─{`date +%H:%M`}`[ $USER = root ] && echo "\E[91m" || echo "\E[93m"` ${USER} \E[92min \E[7m$PWD_TRUNC\E[27m$brnch`[ "$symb" = "" ] || echo " [$symb]"`$e% \E[0m")'
