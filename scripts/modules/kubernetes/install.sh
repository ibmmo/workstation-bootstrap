#!/usr/bin/env bash

set -euo pipefail

log_info "Installing Kubernetes module"


detect_arch() {

    case "$(uname -m)" in

        aarch64|arm64)
            echo "arm64"
            ;;

        x86_64|amd64)
            echo "amd64"
            ;;

        *)
            log_error "Unsupported architecture: $(uname -m)"
            exit 1
            ;;

    esac

}


install_kubectl_linux() {

    log_info "Installing kubectl"

    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.34/deb/Release.key \
        | sudo gpg --dearmor \
        -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg


    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.34/deb/ /" \
        | sudo tee /etc/apt/sources.list.d/kubernetes.list >/dev/null


    sudo apt-get update

    sudo apt-get install -y kubectl

}


install_helm_linux() {

    log_info "Installing Helm"

    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
        | bash

}


install_k9s_linux() {

    log_info "Installing k9s"

    local arch
    arch="$(detect_arch)"

    curl -L \
        "https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_${arch}.tar.gz" \
        -o /tmp/k9s.tar.gz


    tar -xzf /tmp/k9s.tar.gz -C /tmp k9s


    sudo mv /tmp/k9s /usr/local/bin/k9s


    rm -f /tmp/k9s.tar.gz

}


install_kind_linux() {

    log_info "Installing kind"

    local arch
    arch="$(detect_arch)"


    curl -Lo /tmp/kind \
        "https://kind.sigs.k8s.io/dl/latest/kind-linux-${arch}"


    chmod +x /tmp/kind

    sudo mv /tmp/kind /usr/local/bin/kind

}


install_kubectx_linux() {

    log_info "Installing kubectx"

    git clone \
        https://github.com/ahmetb/kubectx.git \
        /tmp/kubectx


    sudo mv /tmp/kubectx/kubectx /usr/local/bin/


    rm -rf /tmp/kubectx

}


install_missing_tools_linux() {

    if [[ "$(uname -s)" != "Linux" ]]; then
        return
    fi


    command -v kubectl >/dev/null 2>&1 || install_kubectl_linux

    command -v helm >/dev/null 2>&1 || install_helm_linux

    command -v k9s >/dev/null 2>&1 || install_k9s_linux

    command -v kind >/dev/null 2>&1 || install_kind_linux

    command -v kubectx >/dev/null 2>&1 || install_kubectx_linux

}


install_missing_tools_linux


log_info "Checking kubectl"

kubectl version --client


log_info "Checking Helm"

helm version --short


log_info "Checking k9s"

k9s version


log_info "Checking kind"

kind version


log_info "Checking kubectx"

kubectx --version


log_success "Kubernetes module validated"
