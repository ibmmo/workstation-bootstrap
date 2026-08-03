#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

source "${ROOT_DIR}/scripts/lib/log.sh"


BREWFILE="${ROOT_DIR}/packages/macos/Brewfile"


log_section "Installing macOS packages"


if ! command -v brew >/dev/null 2>&1; then

    log_info "Homebrew not found"

    log_info "Installing Homebrew"

    NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    eval "$(/opt/homebrew/bin/brew shellenv)"

else

    log_info "Homebrew already installed"

fi


if [[ ! -f "${BREWFILE}" ]]; then

    log_error "Brewfile not found: ${BREWFILE}"
    exit 1

fi


log_info "Installing packages from Brewfile"

brew bundle install \
    --file "${BREWFILE}"


log_success "macOS packages installation completed"
