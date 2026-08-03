# Workstation Bootstrap Architecture

## Overview

Workstation Bootstrap is designed as a modular and configuration-driven framework.

The bootstrap engine detects the target platform, loads the configuration, and executes enabled modules.

The architecture is designed to support:

- macOS Apple Silicon
- Linux distributions
- ARM64 and x86_64 architectures

## Global architecture

```text
workstation-bootstrap/

├── bootstrap.sh
│
├── config/
│   └── bootstrap.yaml
│
├── scripts/
│
│   ├── lib/
│   │
│   │   ├── log.sh
│   │   ├── platform.sh
│   │   ├── config.sh
│   │   ├── verify.sh
│   │   └── module.sh
│   │
│   └── modules/
│
│       ├── system_packages/
│       ├── aws/
│       ├── azure/
│       ├── hashicorp/
│       ├── kubernetes/
│       ├── docker/
│       └── terminal/
│
├── packages/
│
├── tests/
│
└── docs/
```

## Bootstrap workflow

The execution flow is:

```text
bootstrap.sh

      |
      v

Detect operating system

      |
      v

Detect architecture

      |
      v

Load configuration

      |
      v

Read enabled modules

      |
      v

Execute modules sequentially

      |
      v

Validate installation

      |
      v

Display completion status
```

## Core components

## bootstrap.sh

The main entry point.

Responsibilities:

- initialize the framework
- detect platform information
- load configuration
- execute enabled modules

## Configuration layer

Configuration file:

```text
config/bootstrap.yaml
```

The configuration controls:

- enabled modules
- platform options
- future customization parameters

Example:

```yaml
modules:

  docker: true
  kubernetes: true
  terminal: true
```

## Library layer

The library layer provides reusable functions.

### platform.sh

Responsibilities:

- detect operating system
- detect CPU architecture
- detect Linux distribution

### config.sh

Responsibilities:

- load configuration
- identify enabled modules
- retrieve configuration values

### module.sh

Responsibilities:

- locate modules
- execute module installation scripts
- validate module execution

### log.sh

Responsibilities:

- standardize output
- provide information, warning and error messages

### verify.sh

Responsibilities:

- provide validation helpers

## Module architecture

Each module follows a common structure.

Example:

```text
scripts/modules/docker/

├── install.sh
└── files/
```

A module is responsible for:

- installing required software
- validating installation
- reporting status

## Current modules

### system_packages

Installs base operating system dependencies.

### aws

Provides AWS CLI and AWS tooling.

### azure

Provides Azure CLI and Azure tooling.

### hashicorp

Provides Infrastructure as Code tooling:

- Terraform
- Packer
- Ansible

### kubernetes

Provides Kubernetes ecosystem tools:

- kubectl
- Helm
- k9s
- kind
- kubectx

### docker

Provides Docker validation.

Responsibilities:

- verify Docker CLI
- verify Docker daemon
- validate Docker availability

The validation does not require pulling external images.

### terminal

Provides training workstation customization.

Responsibilities:

- detect user shell
- install training aliases
- configure shell integration

Supported shells:

- zsh
- bash

## Design principles

The project follows these principles:

### Idempotency

Running the bootstrap multiple times should not corrupt the workstation.

### Modularity

Each capability is isolated in a dedicated module.

### Configuration driven

Features are enabled or disabled through configuration.

### Platform awareness

The framework adapts to the target operating system and architecture.

## Future extensions

Possible future modules:

- security
- training profiles
- automated reporting
- additional cloud tooling
