#!/usr/bin/env bash

set -euo pipefail

log_info "Installing Azure module"

log_info "Checking Azure CLI"

if command -v az >/dev/null 2>&1; then
    az version | head -n 5
else
    log_error "Azure CLI not found"
    exit 1
fi


log_info "Checking Azure Developer CLI"

if command -v azd >/dev/null 2>&1; then
    azd version
else
    log_error "Azure Developer CLI not found"
    exit 1
fi


log_success "Azure module validated"
