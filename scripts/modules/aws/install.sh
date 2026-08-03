#!/usr/bin/env bash

set -euo pipefail

log_info "Installing AWS module"


install_aws_cli_linux() {

    log_info "Installing AWS CLI v2"

    local tmp_dir

    tmp_dir="$(mktemp -d)"

    curl -sS "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" \
        -o "${tmp_dir}/awscliv2.zip"

    unzip -q "${tmp_dir}/awscliv2.zip" -d "${tmp_dir}"

    sudo "${tmp_dir}/aws/install" --update

    rm -rf "${tmp_dir}"

}


install_sam_cli_linux() {

    log_info "Installing AWS SAM CLI"

    local tmp_dir

    tmp_dir="$(mktemp -d)"

    curl -sS \
        "https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-arm64.zip" \
        -o "${tmp_dir}/aws-sam-cli.zip"

    unzip -q "${tmp_dir}/aws-sam-cli.zip" -d "${tmp_dir}/sam"

    sudo "${tmp_dir}/sam/install"

    rm -rf "${tmp_dir}"

}


ensure_aws_cli() {

    if command -v aws >/dev/null 2>&1; then

        log_info "AWS CLI already installed"

    else

        case "$(uname -s)" in

            Darwin)

                log_error "AWS CLI missing. Install through Homebrew system packages."

                exit 1

                ;;


            Linux)

                install_aws_cli_linux

                ;;


            *)

                log_error "Unsupported operating system"
                exit 1

                ;;

        esac

    fi

}


ensure_sam_cli() {

    if command -v sam >/dev/null 2>&1; then

        log_info "AWS SAM CLI already installed"

    else

        case "$(uname -s)" in

            Darwin)

                log_error "AWS SAM CLI missing. Install through Homebrew system packages."

                exit 1

                ;;


            Linux)

                install_sam_cli_linux

                ;;


            *)

                log_error "Unsupported operating system"
                exit 1

                ;;

        esac

    fi

}


log_info "Checking AWS CLI"

ensure_aws_cli

aws --version


log_info "Checking AWS SAM CLI"

ensure_sam_cli

sam --version


log_success "AWS module validated"
