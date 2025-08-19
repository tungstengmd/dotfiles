#!/bin/ksh
#shellcheck disable=SC2006,SC2276,SC2086,SC2127,SC2015,SC2288,SC2069
function PWD_TRUNC.get {
    .sh.value="`pwd | sed -e "s|$HOME|~|" -e "s|\(\.\{0,1\}[^/]\)[^/]*/|\1/|g"`"
}
function RPROMPT.get {
    #---check version for common tools or languages---#
    [[ -e Dockerfile || -e .dockerignore ]] && { type docker >/dev/null 2>&1 && .sh.value+=" v`docker -v | awk '{print $3}'`, " || type podman >/dev/null 2>&1 && .sh.value+=" v`podman -v | awk '{print $3}'`, "; }
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
    { [ -e *.sln ] || [ -e *.@(cs|fs|x)proj ]; } && type dotnet >/dev/null 2>&1 && .sh.value+=" v`dotnet --list-sdks | grep $(grep .0 $(find . -print | grep -K "*.@(cs|fs|x)proj") | sed 's/<[^<>]*>//g;s/net//;s/.0//') | awk 'END{print $1}'`, "
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
    [[ -n $SSH_CLIENT ]] && { .sh.value+="$(who -m | tr -d '()' | awk '{print $5" ("$2")"}')"; [[ $t = "" ]] || .sh.value+=", "; } || .sh.value+="`tty | sed -e 's|/dev/||'`, "
    [[ -n $VIRTUAL_ENV || -n $PIPENV_ACTIVE || -n $CONDA_DEFAULT_ENV ]] && .sh.value+="venv active, "
    [[ $failsafe = 0 ]] && .sh.value+="took $(($(date -e) - $t))s" || .sh.value+="timeless"
    failsafe=1
}
function PS2.get {
    (( i++ ))
    .sh.value=$'\E[92m«\E[94m'$i$'\E[92m»\E[0m  '
}
# sorts out the time variable, the i variable used in PS2 and the transient prompt
trap '[[ ${istrans:-u} = u  ]] || t="$(date -e)"; [[ $istrans = 0 && $TERM != dumb ]] && { tput cuu $((`fc -lnN0 | sed "s/[[:blank:]]//" | wc -l`+1)); tput ed; print -n "\E[92m\E[7m$PWD_TRUNC\E[27m-%\E[0m "; fc -lnN0 | sed "s/[[:blank:]]//"; istrans=; }; failsafe=0' DEBUG
function prompt {
    symb=
    [[ $e = 0 ]] && { owo="\E[92mowo"; e="\n\E[92m╰──"; } || { owo="\E[91momo\E[92m"; e=" «\E[91m$e/SIG`kill -l $e`\E[92m»\E[0;91m\nx  "; }
    brnch="`git branch --show-current 2>/dev/null`"
    [ "$brnch" = "" ] || brnch=" ($brnch"
    case `git status 2>&1` in
        *"has diverged"*) symb+="%" ;;&
        *"branch is behind"*) symb+="<" ;;&
        *"ahead of"*) symb+=">" ;;&
        *"new file:"*) symb+="A" ;;&
        *"deleted"*) symb+="D" ;;&
        *"renamed"*) symb+="R" ;;&
        *"Untracked"*) symb+="U" ;;&
        *"modified"*) symb+="M" ;;&
        *"detached"*) brnch="`git branch | head -1 | sed "s/)//"`"; brnch=" (${brnch##* }" ;;&
        ?) symb=
    esac
    git rev-parse --verify MERGE_HEAD >/dev/null 2>&1 && brnch+="/"
    git rev-parse --verify CHERRY_PICK_HEAD >/dev/null 2>&1 && brnch+="/🍒"
    git rev-parse --verify REVERT_HEAD >/dev/null 2>&1 && brnch+="/↩"
    git rev-parse --verify REBASE_HEAD >/dev/null 2>&1 && brnch+="/"
    git rev-parse --verify BISECT_LOG >/dev/null 2>&1 && brnch+="/"
    brnch+=")"
    print -n "\E[92m╭─{${owo}}─{`date +%H:%M`}`[ $USER = root ] && echo "\E[91m" || echo "\E[93m"` ${USER} \E[92min \E[7m$PWD_TRUNC\E[27m$brnch`[ "$symb" = "" ] || echo " [$symb]"`$e% \E[0m"
}
function PS1.get {
    e=$?
    istrans=0
    i=0
    if [[ -v RPROMPT ]]; then
        typeset -R "$COLUMNS" rp=$RPROMPT
        .sh.value=$'\E[0m'${rp}$'\r'$(prompt)
    fi
}
