# exit early for non-interactive shells to avoid unwanted output
case $- in
*i*) ;;
*) return ;;
esac

# Resolve symlinks to get the actual script directory for relative imports
_source="${BASH_SOURCE[0]}"
while [ -L "$_source" ]; do
    _dir="$(cd -P "$(dirname "$_source")" && pwd)"
    _source="$(readlink "$_source")"
    [[ "$_source" != /* ]] && _source="$_dir/$_source"
done
BASHRC_DIR="$(cd -P "$(dirname "$_source")" && pwd)"
unset _source _dir

# config
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth # ignore duplicates and commands starting with space
shopt -s checkwinsize  # update COLUMNS and LINES after terminal resize

# bash extensions
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
source "/opt/homebrew/opt/fzf/shell/completion.bash"
source "/opt/homebrew/opt/fzf/shell/key-bindings.bash"

# aliases
alias ll='ls -alF'
alias la='ls -A'

# shared
export XDG_CONFIG_HOME=${HOME}/.config
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# go
export GO_ROOT="$HOME/.local/go"
export GO_PATH="$HOME/go"
export PATH="$GO_ROOT/bin:$GO_PATH/bin:$PATH"

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv bash)"

# ghq
export GHQ_ROOT="$HOME/git"

# fzf
eval "$(fzf --bash)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# lib
for f in "$BASHRC_DIR"/lib/*; do
    [ -r "$f" ] && source "$f"
done
