#!/bin/bash
set -euo pipefail

xcode-select -p &>/dev/null || xcode-select --install
