#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${ROOT_DIR}/scripts/lib/log.sh"
source "${ROOT_DIR}/scripts/lib/platform.sh"
source "${ROOT_DIR}/scripts/lib/verify.sh"
source "${ROOT_DIR}/scripts/lib/config.sh"


load_config


log_section "Workstation Bootstrap"

log_info "Configuration loaded"
log_info "Root directory: ${ROOT_DIR}"


OS="$(detect_os)"
ARCH="$(detect_architecture)"

log_info "Operating system: ${OS}"
log_info "Architecture: ${ARCH}"


case "${OS}" in

    linux)

        DISTRO="$(detect_linux_distribution)"

        log_info "Distribution: ${DISTRO}"

        "${ROOT_DIR}/scripts/linux/install-packages.sh"

        ;;


    macos)

        log_info "macOS detected"

        "${ROOT_DIR}/scripts/macos/install-packages.sh"

        ;;


    *)

        log_error "Unsupported operating system: ${OS}"
        exit 1

        ;;

esac


log_success "Bootstrap framework initialized"
