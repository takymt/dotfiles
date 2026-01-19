#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
REPO_URL="https://github.com/takuto-yamamoto/dotfiles.git"

# Logging utilities (colors enabled if terminal supports it)
if [[ -t 1 ]] && [[ -n "${TERM:-}" ]] && command -v tput &>/dev/null; then
    _C_RESET=$(tput sgr0)
    _C_GREEN=$(tput setaf 2)
    _C_YELLOW=$(tput setaf 3)
    _C_RED=$(tput setaf 1)
    _C_CYAN=$(tput setaf 6)
    _C_GRAY=$(tput setaf 8)
    _C_BOLD=$(tput bold)
else
    _C_RESET="" _C_GREEN="" _C_YELLOW="" _C_RED="" _C_CYAN="" _C_GRAY="" _C_BOLD=""
fi

log_section() {
    echo
    echo "${_C_BOLD}${_C_CYAN}▶ $1${_C_RESET}"
    echo "${_C_GRAY}──────────────────────────────────────────${_C_RESET}"
}
log_step() { echo "  ${_C_CYAN}→${_C_RESET} $1"; }
log_success() { echo "  ${_C_GREEN}✓${_C_RESET} $1"; }
log_warn() { echo "  ${_C_YELLOW}⚠${_C_RESET} $1"; }
log_error() { echo "  ${_C_RED}✗${_C_RESET} $1"; }
log_info() { echo "  ${_C_GRAY}$1${_C_RESET}"; }

confirm() {
    log_section "takuto-yamamoto/dotfiles installer"
    echo "This script will:"
    log_info "- overwrite shell config files using symlinks"
    log_info "- overwrite configs under ~/.config"
    log_info "- install packages (may use sudo and network)"
    echo
    read -rp "Proceed? [y/N]: " ans
    [[ "$ans" =~ ^[Yy]$ ]] || return 1

    # keep alive in background
    sudo -v
    while true; do
        sudo -n true
        sleep 50
        kill -0 "$$" || exit
    done 2>/dev/null &
}

setup_dotfiles() {
    log_section "Setting up dotfiles"
    if [ ! -d "$DOTFILES_DIR" ]; then
        log_step "Cloning dotfiles"
        if git clone --quiet "$REPO_URL" "$DOTFILES_DIR"; then
            log_success "Dotfiles cloned"
        else
            log_error "Failed to clone dotfiles"
            return 1
        fi
    elif [ -d "$DOTFILES_DIR/.git" ]; then
        log_step "Updating existing dotfiles"
        if git -C "$DOTFILES_DIR" pull --ff-only --quiet; then
            log_success "Dotfiles updated"
        else
            log_warn "Local and remote have diverged"
            log_info "Resolve manually: cd $DOTFILES_DIR && git status"
        fi
    else
        log_error "$DOTFILES_DIR exists but is not a git repo"
        return 1
    fi
}

link_configs() {
    log_section "Linking configuration files"

    log_step "Linking bash configs"
    for f in .bashrc .bash_profile; do
        ln -sfn "$DOTFILES_DIR/bash/$f" "$HOME/$f"
    done

    log_step "Linking XDG configs"
    mkdir -p "$HOME/.config"
    for dir in "$DOTFILES_DIR/.config"/*; do
        name="$(basename "$dir")"
        ln -sfn "$dir" "$HOME/.config/$name"
    done

    log_step "Linking non-XDG config"
    ln -sfn "$DOTFILES_DIR/.config/czg/cz.config.mjs" "$HOME/cz.config.mjs"

    # TODO: migrate current vscode/iTerm2 settings
    # TODO: support non-macOS platforms
    # ln -sfn "$DOTFILES_DIR/.config/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"

    log_success "All configs linked"
}

install_packages() {
    [ -d "$DOTFILES_DIR/install" ] || return 0

    local tmpfile
    tmpfile=$(mktemp)
    trap 'rm -f "$tmpfile"' EXIT INT TERM

    log_section "Installing packages"
    for dir in common darwin; do # TODO: 依存関係宣言できる方法に変更する
        for script in "$DOTFILES_DIR/install/$dir"/*.sh; do
            [ -f "$script" ] || continue

            script_name="$(basename "$script")"
            log_step "$script_name"

            if bash "$script" >"$tmpfile" 2>&1; then
                log_success "$script_name"
            else
                log_error "$script_name failed"
                log_info "$(cat "$tmpfile")"
            fi
        done
    done
}

main() {
    confirm || exit 1
    setup_dotfiles || exit 1
    link_configs
    install_packages

    log_section "Installation complete"
    log_success "dotfiles installed successfully!"
    log_info "Restart your terminal for \$SHELL to update"
    log_info "Launching bash..."
    exec bash --login
}

main
