# Changelog

All notable changes to this project are documented in this file.

## v1.2.0

Release: Workstation Bootstrap stable baseline.

### Added

- Configuration-driven module execution
- Terminal customization module
- Training aliases for cloud and DevOps sessions
- Shell integration for zsh and bash
- ARM64 platform validation
- Debian 12 ARM64 support
- macOS Apple Silicon support

### Added modules

- terminal

The terminal module provides:

- training aliases
- shell detection
- shell integration

### Improved

- Docker validation workflow
- Kubernetes tooling validation
- Module execution framework
- Platform detection
- Architecture detection

### Removed

- Development module

The development module was removed because it was not required for the target training environments.

### Disabled

- Security module

The security module remains available for future implementation but is disabled by default.

## v0.1.0

Initial project version.

### Added

- Initial bootstrap framework
- Basic module structure
- First platform detection capabilities
