#!/usr/bin/env bash

CONFIG_FILE="${ROOT_DIR}/config/bootstrap.yaml"


load_config() {

    if [[ ! -f "${CONFIG_FILE}" ]]; then
        echo "Configuration file not found: ${CONFIG_FILE}"
        return 1
    fi

}


module_enabled() {

    local module="$1"

    grep -q "^  ${module}: true" "${CONFIG_FILE}"

}
