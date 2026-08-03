#!/usr/bin/env bash

set -euo pipefail

log_info "Installing Azure module"


install_azure_cli_linux() {

    log_info "Installing Azure CLI"

    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

}


install_azd_linux() {

    log_info "Installing Azure Developer CLI"

    local tmp_dir

    tmp_dir="$(mktemp -d)"


    curl -fsSL https://aka.ms/install-azd.sh | bash


    rm -rf "${tmp_dir}"

}


ensure_azure_cli() {

    if command -v az >/dev/null 2>&1; then

        log_info "Azure CLI already installed"

    else

        case "$(uname -s)" in

            Linux)

                install_azure_cli_linux

                ;;

            Darwin)

                log_error "Azure CLI missing. Install through Homebrew."

                exit 1

                ;;

            *)

                log_error "Unsupported operating system"

                exit 1

                ;;

        esac

    fi

}


ensure_azd() {

    if command -v azd >/dev/null 2>&1; then

        log_info "Azure Developer CLI already installed"

    else

        case "$(uname -s)" in

            Linux)

                install_azd_linux

                ;;

            Darwin)

                log_error "Azure Developer CLI missing. Install through Homebrew."

                exit 1

                ;;

            *)

                log_error "Unsupported operating system"

                exit 1

                ;;

        esac

    fi

}


log_info "Checking Azure CLI"

ensure_azure_cli

az version | head -n 5


log_info "Checking Azure Developer CLI"

ensure_azd

azd version


log_success "Azure module validated"
