# Workstation Bootstrap User Guide

## Introduction

This guide explains how to prepare a workstation using Workstation Bootstrap.

The framework is designed for cloud, DevOps and Kubernetes training environments.

## Requirements

Before starting:

- a supported operating system
- Internet connectivity
- a user account with administrative privileges

Validated platforms:

- macOS Apple Silicon
- Debian 12 ARM64

## Installation

Clone the repository:

```bash
git clone https://github.com/ibmmo/workstation-bootstrap.git
```

Move into the project directory:

```bash
cd workstation-bootstrap
```

Start the bootstrap:

```bash
./bootstrap.sh
```

The installation process is automatic.

The script will:

- detect the operating system
- detect the architecture
- install required tools
- validate components
- configure the terminal environment

## After installation

Close the current terminal session.

Open a new terminal session to load the training aliases.

## Validation

Verify the main tools:

### AWS

```bash
aws --version
```

Check AWS identity:

```bash
awswho
```

### Azure

```bash
az version
```

Check Azure account:

```bash
azwho
```

### Kubernetes

Check kubectl:

```bash
kubectl version --client
```

Common shortcuts:

```bash
k
kgp
kgn
```

### Terraform

Check Terraform:

```bash
terraform version
```

Shortcut:

```bash
tf
```

### Docker

Check Docker:

```bash
docker version
```

Shortcuts:

```bash
d
dps
```

## Terminal customization

The terminal module creates:

```text
~/.training_aliases
```

This file contains shortcuts for training activities.

Examples:

```bash
awswho
azwho

k
kgp
kgn

tf
tfp

d
dps
```

Supported shells:

- zsh on macOS
- bash on Linux

## Troubleshooting

### Bootstrap fails

Check the error message displayed during execution.

Run again:

```bash
./bootstrap.sh
```

The bootstrap is designed to be executed multiple times.

### Aliases are missing

Open a new terminal session.

If required, reload the shell configuration:

Linux:

```bash
source ~/.bashrc
```

macOS:

```bash
source ~/.zshrc
```

## Support

For issues or improvements, report the problem through the project repository.
