#!/bin/bash
set -euo pipefail

VERSION="1.23.5"
INSTALL_DIR="${HOME}/.local/go"

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

TARBALL="go${VERSION}.${OS}-${ARCH}.tar.gz"
DOWNLOAD_URL="https://go.dev/dl/${TARBALL}"

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

# https://go.dev/doc/install
curl -fsSL -o "${TMPDIR}/${TARBALL}" "$DOWNLOAD_URL"
rm -rf "$INSTALL_DIR"
mkdir -p "$(dirname "$INSTALL_DIR")"
tar -C "$(dirname "$INSTALL_DIR")" -xzf "${TMPDIR}/${TARBALL}"
