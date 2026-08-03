#!/usr/bin/env bash

CONFIG_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CONFIG_FILE="${CONFIG_ROOT}/config/bootstrap.yaml"


load_config() {

    if [[ ! -f "${CONFIG_FILE}" ]]; then
        echo "[ERROR] Configuration file not found: ${CONFIG_FILE}"
        return 1
    fi

}


module_enabled() {

    local module="$1"

    if grep -Eq "^  ${module}: true" "${CONFIG_FILE}"; then
        return 0
    fi

    return 1

}


get_config_value() {

    local key="$1"

    grep -E "^  ${key}:" "${CONFIG_FILE}" \
        | awk '{print $2}'

}
