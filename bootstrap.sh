#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${ROOT_DIR}/scripts/lib/log.sh"
source "${ROOT_DIR}/scripts/lib/platform.sh"
source "${ROOT_DIR}/scripts/lib/verify.sh"
source "${ROOT_DIR}/scripts/lib/config.sh"
source "${ROOT_DIR}/scripts/lib/module.sh"


log_section "Workstation Bootstrap"

log_info "Root directory: ${ROOT_DIR}"


OS="$(detect_os)"
ARCH="$(detect_architecture)"

load_config

log_info "Configuration loaded"
log_info "Operating system: ${OS}"
log_info "Architecture: ${ARCH}"


if [[ "${OS}" == "linux" ]]; then

    DISTRO="$(detect_linux_distribution)"
    log_info "Distribution: ${DISTRO}"

fi


run_module system_packages
run_module aws


log_success "Bootstrap framework initialized"
