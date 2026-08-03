# Workstation Bootstrap

Automated workstation preparation framework for cloud, DevOps and Kubernetes training environments.

The objective is to provide a reproducible workstation setup for trainees and instructors across multiple platforms.

## Supported platforms

Validated platforms:

- macOS Apple Silicon (ARM64)
- Debian 12 ARM64

## Objectives

Workstation Bootstrap automates the preparation of training workstations:

- installation of required cloud and DevOps tooling
- validation of installed components
- terminal customization
- consistent workstation configuration
- reduction of manual setup operations

## Features

The framework provides:

- operating system detection
- architecture detection
- configuration-driven module execution
- modular installation architecture
- cloud tooling installation
- Kubernetes tooling installation
- Docker validation
- terminal customization

## Installation

Clone the repository:

```bash
git clone https://github.com/ibmmo/workstation-bootstrap.git
cd workstation-bootstrap
```

Run the bootstrap:

```bash
./bootstrap.sh
```

After completion, open a new terminal session.

## Configuration

Modules are controlled through:

```text
config/bootstrap.yaml
```

Example:

```yaml
modules:

  system_packages: true
  docker: true
  aws: true
  azure: true
  hashicorp: true
  kubernetes: true
  terminal: true
```

Modules can be enabled or disabled without modifying the bootstrap engine.

## Modules

| Module | Description |
|---|---|
| system_packages | Base operating system packages |
| aws | AWS CLI and AWS tooling |
| azure | Azure CLI and Azure tooling |
| hashicorp | Terraform, Packer and Ansible tooling |
| kubernetes | kubectl, Helm, k9s, kind and kubectx |
| docker | Docker CLI and Docker validation |
| terminal | Training aliases and shell customization |

## Terminal customization

The terminal module creates:

```text
~/.training_aliases
```

This file contains shortcuts used during cloud and DevOps training sessions.

Examples:

```bash
awswho
azwho

k
kgp
kgn

tf
tfi
tfp

d
dps
```

Supported shells:

- zsh on macOS
- bash on Linux

## Design principles

The project follows these principles:

- reproducibility
- idempotent execution
- modular architecture
- platform awareness
- minimal manual configuration

## Repository structure

```text
workstation-bootstrap/

├── bootstrap.sh
├── config/
│   └── bootstrap.yaml
├── scripts/
│   ├── lib/
│   └── modules/
├── packages/
├── tests/
└── docs/
```

## Version

Current stable version:

v1.2.0

## License

See LICENSE file.
