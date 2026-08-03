#!/usr/bin/env bash

set -euo pipefail

log_info "Installing AWS module"


detect_aws_cli_arch() {

    case "$(uname -m)" in

        aarch64|arm64)
            echo "aarch64"
            ;;

        x86_64|amd64)
            echo "x86_64"
            ;;

        *)
            log_error "Unsupported architecture: $(uname -m)"
            exit 1
            ;;

    esac

}


detect_sam_cli_arch() {

    case "$(uname -m)" in

        aarch64|arm64)
            echo "arm64"
            ;;

        x86_64|amd64)
            echo "x86_64"
            ;;

        *)
            log_error "Unsupported architecture: $(uname -m)"
            exit 1
            ;;

    esac

}


validate_zip() {

    local file="$1"

    if ! file "${file}" | grep -qi zip; then

        log_error "Downloaded file is not a valid ZIP archive"

        file "${file}"

        exit 1

    fi

}


install_aws_cli_linux() {

    log_info "Installing AWS CLI v2"

    local tmp_dir

    tmp_dir="$(mktemp -d)"


    curl -L -sS \
        "https://awscli.amazonaws.com/awscli-exe-linux-$(detect_aws_cli_arch).zip" \
        -o "${tmp_dir}/awscliv2.zip"


    validate_zip "${tmp_dir}/awscliv2.zip"


    unzip -q "${tmp_dir}/awscliv2.zip" \
        -d "${tmp_dir}"


    sudo "${tmp_dir}/aws/install" --update


    rm -rf "${tmp_dir}"

}


install_sam_cli_linux() {

    log_info "Installing AWS SAM CLI"

    local tmp_dir

    tmp_dir="$(mktemp -d)"


    curl -L -sS \
        "https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-$(detect_sam_cli_arch).zip" \
        -o "${tmp_dir}/aws-sam-cli.zip"


    validate_zip "${tmp_dir}/aws-sam-cli.zip"


    unzip -q "${tmp_dir}/aws-sam-cli.zip" \
        -d "${tmp_dir}/sam"


    sudo "${tmp_dir}/sam/install"


    rm -rf "${tmp_dir}"

}


ensure_aws_cli() {

    if command -v aws >/dev/null 2>&1; then

        log_info "AWS CLI already installed"

    else

        case "$(uname -s)" in

            Linux)
                install_aws_cli_linux
                ;;

            Darwin)

                log_error "AWS CLI missing. Install through Homebrew."

                exit 1

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

            Linux)
                install_sam_cli_linux
                ;;

            Darwin)

                log_error "AWS SAM CLI missing. Install through Homebrew."

                exit 1

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
