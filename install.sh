#!/bin/bash
set -e

DOTFILES_DIR="$HOME/dotfiles"
REPO_URL="https://github.com/takuto-yamamoto/dotfiles.git"

if [ ! -d "$DOTFILES_DIR" ]; then
    git clone "$REPO_URL" "$DOTFILES_DIR"
fi

ln -sf "$DOTFILES_DIR/bash/.bashrc" ~/.bashrc
ln -sf "$DOTFILES_DIR/bash/.bash_profile" ~/.bash_profile
ln -sf "$DOTFILES_DIR/bash/.bash_aliases" ~/.bash_aliases

echo "dotfiles installed!"
