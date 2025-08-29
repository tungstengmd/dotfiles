eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export DOTNET_ROOT=$HOME/.dotnet
PATH+=:$DOTNET_ROOT:$DOTNET_ROOT/tools:$HOME/.cargo/bin:$HOME/.local/bin
case $0 in
    *"dash") ENV=$HOME/.shrc
esac
