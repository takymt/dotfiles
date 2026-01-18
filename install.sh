#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
REPO_URL="https://github.com/takuto-yamamoto/dotfiles.git"

echo "==> This script will:"
echo "- overwrite shell config files using symlinks"
echo "- overwrite configs under ~/.config"
echo "- install packages (may use sudo and network)"
echo
read -rp "Proceed? [y/N]: " ans
[[ "$ans" =~ ^[Yy]$ ]] || exit 1

echo "==> Setting up dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
    git clone "$REPO_URL" "$DOTFILES_DIR"
    echo "==> Dotfiles cloned to $DOTFILES_DIR"
elif [ -d "$DOTFILES_DIR/.git" ]; then
    echo "==> Updating existing dotfiles at $DOTFILES_DIR"
    git -C "$DOTFILES_DIR" pull --ff-only || {
        echo "Warning: Local and remote have diverged."
        echo "Resolve manually: cd $DOTFILES_DIR && git status"
    }
else
    echo "==> $DOTFILES_DIR exists but is not a git repo"
    exit 1
fi

echo "==> Linking bash configs"
for f in .bashrc .bash_profile; do
    ln -sfn "$DOTFILES_DIR/bash/$f" "$HOME/$f"
done

echo "==> Linking XDG configs"
mkdir -p "$HOME/.config"
for dir in "$DOTFILES_DIR/.config"/*; do
    name="$(basename "$dir")"
    ln -sfn "$dir" "$HOME/.config/$name"
done

echo "==> Linking non-XDG config"
ln -sfn "$DOTFILES_DIR/.config/czg/cz.config.mjs" "$HOME/cz.config.mjs"

# install packages
if [ -d "$DOTFILES_DIR/install" ]; then
    echo "==> Installing packages"
    # TODO: 依存関係宣言できる方法に変更する
    for dir in common darwin; do
        for script in "$DOTFILES_DIR/install/$dir"/*.sh; do
            [ -f "$script" ] || continue
            echo "  -> $(basename "$script")"
            bash "$script"
        done
    done
fi

echo "==> ✅ dotfiles installed successfully!"
echo "==> Run 'source ~/.bashrc' or open a new terminal to apply changes."
