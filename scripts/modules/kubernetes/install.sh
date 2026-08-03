#!/usr/bin/env bash

set -euo pipefail

log_info "Installing Kubernetes module"


log_info "Checking kubectl"

if command -v kubectl >/dev/null 2>&1; then
    kubectl version --client
else
    log_error "kubectl not found"
    exit 1
fi


log_info "Checking Helm"

if command -v helm >/dev/null 2>&1; then
    helm version --short
else
    log_error "helm not found"
    exit 1
fi


log_info "Checking k9s"

if command -v k9s >/dev/null 2>&1; then
    k9s version
else
    log_error "k9s not found"
    exit 1
fi


log_info "Checking kind"

if command -v kind >/dev/null 2>&1; then
    kind version
else
    log_error "kind not found"
    exit 1
fi


log_info "Checking kubectx"

if command -v kubectx >/dev/null 2>&1; then
    kubectx --version
else
    log_error "kubectx not found"
    exit 1
fi


log_success "Kubernetes module validated"
