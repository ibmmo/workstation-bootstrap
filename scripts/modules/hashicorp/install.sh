#!/usr/bin/env bash

set -euo pipefail

log_info "Installing HashiCorp module"


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
