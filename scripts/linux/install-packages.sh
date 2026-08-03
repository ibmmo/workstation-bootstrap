#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

source "${ROOT_DIR}/scripts/lib/log.sh"
source "${ROOT_DIR}/scripts/lib/platform.sh"


DISTRO="$(detect_linux_distribution)"

log_section "Installing system packages"

case "${DISTRO}" in

    debian)

        PACKAGE_FILE="${ROOT_DIR}/packages/debian/packages.txt"

        log_info "Using Debian package manager (apt)"

        sudo apt update

        while IFS= read -r package; do

            [[ -z "${package}" ]] && continue
            [[ "${package}" =~ ^# ]] && continue

            if dpkg -s "${package}" >/dev/null 2>&1; then
                log_info "${package} already installed"
            else
                log_info "Installing ${package}"
                sudo apt install -y "${package}"
            fi

        done < "${PACKAGE_FILE}"

        ;;


    redhat)

        PACKAGE_FILE="${ROOT_DIR}/packages/redhat/packages.txt"

        log_info "Using RedHat package manager (dnf)"

        sudo dnf install -y $(grep -v '^#' "${PACKAGE_FILE}")

        ;;


    *)

        log_error "Unsupported Linux distribution: ${DISTRO}"
        exit 1

        ;;

esac


log_success "System packages installation completed"
