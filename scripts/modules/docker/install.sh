#!/usr/bin/env bash

set -euo pipefail

log_info "Installing Docker module"


install_docker_linux() {

    log_info "Installing Docker Engine"

    sudo apt-get update

    sudo apt-get install -y \
        ca-certificates \
        curl \
        gnupg


    sudo install -m 0755 -d /etc/apt/keyrings


    curl -fsSL https://download.docker.com/linux/debian/gpg \
        | sudo gpg --dearmor \
        -o /etc/apt/keyrings/docker.gpg


    sudo chmod a+r /etc/apt/keyrings/docker.gpg


    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo ${VERSION_CODENAME}) stable" \
      | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null


    sudo apt-get update


    sudo apt-get install -y \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-buildx-plugin \
        docker-compose-plugin


    sudo systemctl enable docker

}


ensure_docker_cli() {

    if command -v docker >/dev/null 2>&1; then

        log_info "Docker CLI already installed"

        return

    fi


    case "$(uname -s)" in

        Linux)

            install_docker_linux

            ;;


        Darwin)

            log_error "Docker Desktop is not installed"

            exit 1

            ;;


        *)

            log_error "Unsupported operating system"

            exit 1

            ;;

    esac

}


start_docker_service() {

    case "$(uname -s)" in

        Darwin)

            log_info "Starting Docker Desktop"

            open -a Docker

            ;;


        Linux)

            log_info "Starting Docker service"

            sudo systemctl start docker

            ;;

    esac

}


wait_for_docker() {

    local timeout=120
    local elapsed=0


    log_info "Waiting for Docker daemon"


    while true; do

        if docker info >/dev/null 2>&1; then

            log_info "Docker daemon ready"

            return 0

        fi


        if [[ ${elapsed} -ge ${timeout} ]]; then

            log_error "Docker daemon did not become ready"

            docker info || true

            exit 1

        fi


        sleep 5

        elapsed=$((elapsed + 5))

    done

}


log_info "Checking Docker CLI"

ensure_docker_cli

docker --version


log_info "Checking Docker daemon"

if docker info >/dev/null 2>&1; then

    log_info "Docker daemon already running"

else

    start_docker_service

    wait_for_docker

fi


log_info "Running Docker validation container"

docker run --rm hello-world >/dev/null


log_success "Docker module validated"
