#!/usr/bin/env bash

set -euo pipefail

log_info "Installing AWS module"

log_info "Checking AWS CLI"

if command -v aws >/dev/null 2>&1; then
    aws --version
else
    log_error "AWS CLI not found"
    exit 1
fi


log_info "Checking AWS SAM CLI"

if command -v sam >/dev/null 2>&1; then
    sam --version
else
    log_error "AWS SAM CLI not found"
    exit 1
fi


log_success "AWS module validated"
