#!/bin/ksh
#shellcheck disable=SC2006,SC2276,SC2086,SC2127,SC2015,SC2288,SC2069
function PS1_MIN.set {
    istrans=1
}
function PWD_TRUNC.get {
    .sh.value="`pwd | sed -e "s|$HOME|~|" -e "s|\(\.\{0,1\}[^/]\)[^/]*/|\1/|g"`"
}
#---the failsafe variable is set to 1 so that if you press enter it doesn't just show seconds---#
function RPROMPT.get {
    #---check version for common tools or languages---#
    [[ -e Dockerfile || -e .dockerignore ]] && { `# the reasoning for putting each case in braces is because both cases run if not braced`; { type docker >/dev/null 2>&1 && .sh.value+=" v`docker -v | awk '{print $3}'` "; } || { type podman >/dev/null 2>&1 && .sh.value+=" v`podman -v | awk '{print $3}'`, "; }; }
    [[ -e package.json ]] && { `# go through all the runtimes`; { type node >/dev/null 2>&1 && .sh.value+=" `node -v`, "; } || { type deno >/dev/null 2>&1 && .sh.value+=" `deno -v | sed 's/deno /v/'`, "; } || { type bun >/dev/null 2>&1 && .sh.value+=" v`bun -v`, "; }; }
    [[ -e pyproject.toml ]] && type python >/dev/null 2>&1 && .sh.value+=" v`python -V | awk '{print $2}'`, "
    [[ -e Cargo.toml ]] && type rustc >/dev/null 2>&1 && .sh.value+=" v`rustc -V | awk '{print $2}'`, "
    [[ -e Gemfile* ]] && type ruby >/dev/null 2>&1 && .sh.value+=" v `ruby -v | awk '{print $2}'`, "
    [[ -e Package.swift ]] && type swift >/dev/null 2>&1 && .sh.value+=" v`swift -version | awk '{print $4}'`, "
    [[ -e go.mod ]] && type go >/dev/null 2>&1 && .sh.value+=" `go version | awk '{gsub("go", "v", $3); print $3}'`, "
    [[ -e artisan ]] && type php >/dev/null 2>&1 && .sh.value+=" v`php -v | awk '{print $2}'`, "
    [[ -e .cljfmt.edn ]] && type clj >/dev/null 2>&1 && .sh.value+=" v`clj --version | awk '{print $4}'`, "
    [[ -e tsconfig.json ]] && type tsc >/dev/null 2>&1 && .sh.value+=" v`tsc -v | awk '{print $4}'`, "
    [[ -e build.zig ]] && type zig >/dev/null 2>&1 && .sh.value+=" `zig version`, "
    [[ -e gleam.toml ]] && type gleam >/dev/null 2>&1 && .sh.value+=" v`gleam -V | awk '{print $2}'`, "
    [[ -e pubspec.* ]] && type dart >/dev/null 2>&1 && .sh.value+=" `dart --version | awk '{print $4}'`, "
    { [ -e *.sln ] || [ -e *.@(cs|fs|x)proj ]; } && type dotnet >/dev/null 2>&1 && { ver="`dotnet --list-sdks | grep $(grep .0 $(find . -print | grep -K "*.@(cs|fs|x)proj") | sed -e 's/<[^<>]*>//g' -e 's/net//' -e 's/.0//') | awk 'END{print $1}'`"; ver=${ver%%-*}; .sh.value+=" v${ver}, "; }
    [[ -e mix.exs ]] && type elixir >/dev/null 2>&1 && .sh.value+=" v`elixir -v | awk 'END{print $2}'`, "
    [[ -e elm.json || -e elm-package.json || -e .elm-version || -e elm-stuff/ ]] && type elm >/dev/null 2>&1 && .sh.value+=" v`elm --version`, "
    [[ -e rebar.config || -e erlang.mk ]] && type erl >/dev/null 2>&1 && .sh.value+=" `erl -eval '{ok, Version} = file:read_file(filename:join([code:root_dir(), "releases", erlang:system_info(otp_release), "OTP_VERSION"])), io:fwrite(Version), halt().' -noshell`, "
    [[ -e stack.yaml ]] && type ghc >/dev/null 2>&1 && .sh.value+=" `ghc -V | awk '{print $NF}'`, "
    { [ -e build.@(gradle.kts|.sbt|boot) ] || [[ -e pom.xml || -e .java-version || -e deps.edn || -e project.clj || -e .sdkmanrc ]]; } && type java >/dev/null 2>&1 && .sh.value+=" v`java -version 2>&1 | sed -n '1p' | awk '{print $3}' | sed 's/"//g'`, "
    [[ -e Project.toml || -e Manifest.toml ]] && type julia >/dev/null 2>&1 && .sh.value+=" v`julia -v | awk '{print $3}'`, "
    [[ -e lua/ || -e .lua-version ]] && type lua >/dev/null 2>&1 && .sh.value+=" v`lua -v | awk '{print $2}'`, "
    [[ -e .scalaenv || -e .sbtenv ]] && type scala-cli >/dev/null 2>&1 && .sh.value+=" v`scala-cli --version | awk '{print $4}' | sed -n '2p'`"
    { [ -e @(Build|Makefile).PL ] || [ -e cpanfile?(.snapshot) ] || [ -e META.@(json|yml) ] || [ -e .perl-version ]; } && type perl >/dev/null 2>&1 && .sh.value+=" `perl -e 'print $^V'`, "
    #---now for the other stuff---#
    [[ -n $SSH_CLIENT ]] && { .sh.value+="$(who -m | tr -d '()' | awk '{print $5" ("$2")"}')"; [[ $time = "" ]] || .sh.value+=", "; } || .sh.value+="`tty | sed -e 's|/dev/||'`, "
    [[ -n $VIRTUAL_ENV || -n $PIPENV_ACTIVE || -n $CONDA_DEFAULT_ENV ]] && .sh.value+="venv active, "
    [[ $failsafe = 0 ]] && .sh.value+="took $(($(date -e) - $time))s" || .sh.value+="timeless"
    [[ $PS1_MIN = 1 ]] && unset .sh.value
    failsafe=1
}
function PS2.get {
    (( line++ ))
    .sh.value=$'\E[92m«\E[94m'$line$'\E[92m»\E[0m  '
}
# sorts out the time variable, the line variable used in PS2 and the transient prompt
function PS1_SIZE.get {
    [[ $PS1_MIN = 1 ]] && .sh.value=0 || .sh.value=1
}
function transprompt {
    if [[ $istrans = 0 && $TERM != dumb ]]; then 
        tput cuu $((`fc -lnN0 | sed "s/[[:blank:]]//" | wc -l`+${PS1_SIZE}))
        tput ed
        [[ $PS1_MIN = 1 ]] && minprompt || print -n "\E[92m\E[7m$PWD_TRUNC\E[27m-%\E[0m "
        fc -lnN0 | sed "s/[[:blank:]]//"
        istrans=
    fi
    failsafe=0
}
trap '[[ ${istrans:-u} = u  ]] || time="$(date -e)"; [[ $PS1_MIN = 1 ]] || transprompt' DEBUG
function prompt {
    symb=
    brnch="`git branch --show-current 2>/dev/null`"
    [ "$brnch" = "" ] || brnch=" ($brnch)"
    case `git status 2>&1` in
        *"has diverged"*) symb+="%" ;;&
        *"branch is behind"*) symb+="<" ;;&
        *"ahead of"*) symb+=">" ;;&
        *"new file:"*) symb+="A" ;;&
        *"deleted"*) symb+="D" ;;&
        *"renamed"*) symb+="R" ;;&
        *"Untracked"*) symb+="U" ;;&
        *"modified"*) symb+="M" ;;&
        *"detached"*) brnch="`git branch | awk '(NR==1) {print " ("$NF}'`" ;;&
    esac
    [[ $symb = "" ]] || symb=" [$symb]"
    git rev-parse --verify MERGE_HEAD >/dev/null 2>&1 && brnch+="/"
    git rev-parse --verify CHERRY_PICK_HEAD >/dev/null 2>&1 && brnch+="/🍒"
    git rev-parse --verify REVERT_HEAD >/dev/null 2>&1 && brnch+="/↩"
    git rev-parse --verify REBASE_HEAD >/dev/null 2>&1 && brnch+="/"
    git rev-parse --verify BISECT_LOG >/dev/null 2>&1 && brnch+="/"
    if [[ $PS1_MIN = 0 ]]; then
        [[ $error = 0 ]] && { owo="\E[92mowo"; e="\n\E[92m╰──"; } || { owo="\E[91momo\E[92m"; e=" «\E[91m$error/SIG`kill -l $error`\E[92m»\E[0;91m\nx  "; }
        print -n "\E[92m╭─{${owo}}─{`date +%H:%M`}`[ $(whoami) = root ] && print "\E[91m" || print "\E[93m"` ${USER} \E[92min \E[7m$PWD_TRUNC\E[27m$brnch$symb$e% \E[0m"
    else
        istrans=1
        print -n "\E[92m$PWD_TRUNC`[ $error = 0 ] || print "\E[91m [$error]"`\E[94m$brnch$symb \E[0m% "
    fi
}
function PS1.get {
    error=$?
    istrans=0
    line=0
    if [[ -v RPROMPT ]]; then
        typeset -R "$COLUMNS" rp=$RPROMPT
        .sh.value=$'\E[0m'${rp}$'\r'$(prompt)
    fi
}
