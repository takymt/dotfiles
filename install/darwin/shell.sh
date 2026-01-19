#!/bin/bash
set -euo pipefail

HOMEBREW_BASH="/opt/homebrew/bin/bash"

[[ -x "$HOMEBREW_BASH" ]] || exit 1

if ! grep -q "^$HOMEBREW_BASH$" /etc/shells; then
  echo "$HOMEBREW_BASH" | sudo tee -a /etc/shells >/dev/null
fi

if [[ "$SHELL" != "$HOMEBREW_BASH" ]]; then
  sudo chsh -s "$HOMEBREW_BASH" "$USER"
fi
