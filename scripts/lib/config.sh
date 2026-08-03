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

    if grep -Eq "^  ${module}:[[:space:]]*true$" "${CONFIG_FILE}"; then
        return 0
    fi

    return 1

}


get_enabled_modules() {

    awk '
        /^modules:/ { in_modules=1; next }

        in_modules && /^[^[:space:]]/ { exit }

        in_modules &&
        /^[[:space:]]+[A-Za-z0-9_-]+:[[:space:]]*true$/ {

            gsub(":", "", $1)
            print $1

        }
    ' "${CONFIG_FILE}"

}


get_config_value() {

    local key="$1"

    awk -F': *' -v key="${key}" '
        $1 ~ "^[[:space:]]*"key"$" {
            print $2
        }
    ' "${CONFIG_FILE}"

}
