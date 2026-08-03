# Contributing to Workstation Bootstrap

Thank you for contributing to Workstation Bootstrap.

This document describes the recommended workflow for improving the project.

## Development workflow

The project uses Git branches to separate stable releases from ongoing development.

Main branches:

- `main` : stable and validated versions
- `feature/*` : new features or improvements

Direct commits to `main` should be avoided.

## Creating a feature branch

Create a dedicated branch:

```bash
git switch -c feature/my-feature
```

Work on the changes and commit regularly:

```bash
git add .
git commit -m "describe the change"
```

## Code organization

The project is organized into modules.

New capabilities should preferably be implemented as a new module:

```text
scripts/modules/<module-name>/
```

A module should contain:

```text
install.sh
```

The module script should:

- install required components
- validate installation
- return meaningful status messages

## Configuration

Features should be configurable through:

```text
config/bootstrap.yaml
```

Avoid hardcoding enabled or disabled features inside the bootstrap engine.

## Testing requirements

Before submitting changes, validate on supported platforms.

Currently validated:

- macOS Apple Silicon
- Debian 12 ARM64

Minimum validation:

```bash
./bootstrap.sh
```

Verify:

- successful module execution
- installed tools availability
- shell customization if modified

## Commit messages

Use clear commit messages.

Examples:

Feature:

```text
feat: add new training module
```

Bug fix:

```text
fix: correct docker validation
```

Documentation:

```text
docs: update user guide
```

## Pull requests

A pull request should include:

- description of the change
- reason for the change
- validation performed
- possible limitations

## Documentation

Any user-visible change should update the relevant documentation:

- README.md
- USERGUIDE.md
- ARCHITECTURE.md
- CHANGELOG.md
