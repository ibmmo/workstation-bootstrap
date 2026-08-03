#!/usr/bin/env bash

set -euo pipefail

log_info "Installing Docker module"


log_info "Checking Docker CLI"

if ! command -v docker >/dev/null 2>&1; then
    log_error "Docker CLI not found"
    exit 1
fi

docker --version


start_docker_service() {

    case "$(uname -s)" in

        Darwin)

            if [[ -d "/Applications/Docker.app" ]]; then

                log_info "Starting Docker Desktop"

                open -a Docker

            else

                log_error "Docker Desktop not installed"
                exit 1

            fi

            ;;


        Linux)

            if command -v systemctl >/dev/null 2>&1; then

                log_info "Starting Docker service"

                sudo systemctl start docker

            else

                log_error "systemctl not available"
                exit 1

            fi

            ;;


        *)

            log_error "Unsupported operating system"
            exit 1

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

            log_error "Docker daemon did not become ready within ${timeout}s"
            docker info || true
            exit 1

        fi


        echo -n "."

        sleep 5

        elapsed=$((elapsed + 5))

    done

}


log_info "Checking Docker daemon"

if docker info >/dev/null 2>&1; then

    log_info "Docker daemon already running"

else

    start_docker_service

    # Docker Desktop needs time to initialize its Linux VM
    if [[ "$(uname -s)" == "Darwin" ]]; then
        sleep 10
    fi

    wait_for_docker

fi


log_info "Running Docker validation container"

docker run --rm hello-world >/dev/null


log_success "Docker module validated"
