#!/usr/bin/env bash

run_module() {

    local module="$1"

    if ! module_enabled "${module}"; then
        log_info "Module '${module}' disabled"
        return 0
    fi

    log_section "Module: ${module}"

    local script="${ROOT_DIR}/scripts/modules/${module}/install.sh"

    if [[ ! -x "${script}" ]]; then
        log_error "Module '${module}' not implemented"
        return 1
    fi

    source "${script}"

    log_success "Module '${module}' completed"

}
