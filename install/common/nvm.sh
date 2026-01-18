#!/bin/bash
set -euo pipefail

# https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script
export PROFILE="$HOME/.bashrc"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
