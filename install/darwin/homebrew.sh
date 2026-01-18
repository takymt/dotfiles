#!/bin/bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# https://docs.brew.sh/Installation
sudo -v
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install packages
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file="$DIR/.Brewfile"
