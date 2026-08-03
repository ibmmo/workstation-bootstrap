#!/usr/bin/env bash

set -euo pipefail

log_info "Installing HashiCorp module"


install_hashicorp_repository() {

    log_info "Configuring HashiCorp repository"

    curl -fsSL https://apt.releases.hashicorp.com/gpg \
        | sudo gpg --dearmor \
        -o /usr/share/keyrings/hashicorp-archive-keyring.gpg


    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
        | sudo tee /etc/apt/sources.list.d/hashicorp.list >/dev/null


    sudo apt-get update

}


install_hashicorp_tools_linux() {

    install_hashicorp_repository


    log_info "Installing Terraform"

    sudo apt-get install -y terraform


    log_info "Installing Packer"

    sudo apt-get install -y packer


    log_info "Installing Vagrant"

    sudo apt-get install -y vagrant

}


install_ansible_linux() {

    log_info "Installing Ansible"

    sudo apt-get install -y ansible

}


ensure_tools() {


    if [[ "$(uname -s)" == "Linux" ]]; then


        if ! command -v terraform >/dev/null 2>&1 \
        || ! command -v packer >/dev/null 2>&1 \
        || ! command -v vagrant >/dev/null 2>&1; then

            install_hashicorp_tools_linux

        fi


        if ! command -v ansible >/dev/null 2>&1; then

            install_ansible_linux

        fi


    fi

}


ensure_tools


log_info "Checking Terraform"

if command -v terraform >/dev/null 2>&1; then

    terraform version

else

    log_error "Terraform not found"
    exit 1

fi


log_info "Checking Packer"

if command -v packer >/dev/null 2>&1; then

    packer version

else

    log_error "Packer not found"
    exit 1

fi


log_info "Checking Ansible"

if command -v ansible >/dev/null 2>&1; then

    ansible --version | head -n 1

else

    log_error "Ansible not found"
    exit 1

fi


log_info "Checking Vagrant"

if command -v vagrant >/dev/null 2>&1; then

    vagrant --version

else

    log_error "Vagrant not found"
    exit 1

fi


log_success "HashiCorp module validated"
