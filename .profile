eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export DOTNET_ROOT=$HOME/.dotnet
PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.local/share/gem/ruby/3.4.0/bin
case $0 in
    *"dash") ENV=$HOME/.shrc; . $ENV
esac
