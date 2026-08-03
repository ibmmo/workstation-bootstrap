#!/usr/bin/env bash

detect_os() {

    case "$(uname -s)" in

        Darwin)
            echo "macos"
            ;;

        Linux)
            echo "linux"
            ;;

        *)
            echo "unsupported"
            ;;

    esac
}


detect_architecture() {

    case "$(uname -m)" in

        x86_64)
            echo "amd64"
            ;;

        aarch64|arm64)
            echo "arm64"
            ;;

        *)
            echo "unknown"
            ;;

    esac
}


detect_linux_distribution() {

    if [[ ! -f /etc/os-release ]]; then
        echo "unknown"
        return
    fi

    source /etc/os-release

    case "${ID}" in

        debian|ubuntu)
            echo "debian"
            ;;

        fedora|rhel|rocky|almalinux)
            echo "redhat"
            ;;

        *)
            echo "unknown"
            ;;

    esac
}
