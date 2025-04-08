# Transcribulator Scripts

This directory contains utility scripts for the Transcribulator project.

## Development Scripts

- `dev.sh` - Development script for Linux/macOS
- `dev.ps1` - Development script for Windows

These scripts provide a convenient interface for common development tasks:

```bash
# Linux/macOS
./scripts/dev.sh [command]

# Windows
.\scripts\dev.ps1 [command]
```

Available commands:

- `up` - Start the development environment
- `down` - Stop the development environment
- `shell` - Open a shell in the development container
- `build` - Build the project
- `test` - Run tests
- `lint` - Run linting checks
- `format` - Format the code
- `clean` - Clean build artifacts
- `web` - Start the web interface
- `protocol` - Start the protocol handler
- `all` - Start all services
- `help` - Show help message

## Versioning Scripts

- `version.sh` - Semantic versioning script for Linux/macOS
- `version.ps1` - Semantic versioning script for Windows

These scripts help manage semantic versioning for the project:

```bash
# Linux/macOS
./scripts/version.sh [type] [message]

# Windows
.\scripts\version.ps1 [type] [message]
```

Available types:

- `patch` - Increment patch version (bug fixes) - default
- `minor` - Increment minor version (new features, backwards compatible)
- `major` - Increment major version (breaking changes)
- `meta` - Meta version (no code changes, just project maintenance)

Example:

```bash
# Linux/macOS
./scripts/version.sh minor "Added support for Python 3.10"

# Windows
.\scripts\version.ps1 minor "Added support for Python 3.10"
```
