# Contributing to Transcribulator

Thank you for your interest in contributing to Transcribulator! This document provides guidelines and instructions for contributing to the project.

## Code of Conduct

Please be respectful and considerate of others when contributing to this project. We aim to foster an inclusive and welcoming community.

## How to Contribute

### Reporting Bugs

If you find a bug, please create an issue on GitHub with the following information:

- A clear, descriptive title
- A detailed description of the bug
- Steps to reproduce the bug
- Expected behavior
- Actual behavior
- Any relevant logs or error messages
- Your environment (OS, Rust version, etc.)

### Suggesting Features

If you have an idea for a new feature, please create an issue on GitHub with the following information:

- A clear, descriptive title
- A detailed description of the feature
- Why this feature would be useful
- Any relevant examples or use cases

### Pull Requests

1. Fork the repository
2. Create a new branch for your changes
3. Make your changes
4. Run the tests to ensure they pass
5. Submit a pull request

Please include the following in your pull request:

- A clear, descriptive title
- A detailed description of the changes
- Any relevant issue numbers
- Tests for your changes

## Development Setup

Transcribulator uses Docker for development to ensure a consistent environment across all platforms. This approach eliminates the need to install Rust or any other dependencies locally.

### Prerequisites

- Docker
- Docker Compose
- Git

### Setup Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/transcribulator.git
   cd transcribulator
   ```

2. Start the development environment:
   ```bash
   # Linux/macOS
   ./scripts/dev.sh up

   # Windows
   .\scripts\dev.ps1 up
   ```

3. Open a shell in the development container:
   ```bash
   # Linux/macOS
   ./scripts/dev.sh shell

   # Windows
   .\scripts\dev.ps1 shell
   ```

4. Build the project (from inside the container):
   ```bash
   cargo build
   ```

5. Run the tests (from inside the container):
   ```bash
   cargo test
   ```

### Common Development Tasks

You can use the development scripts to perform common tasks:

```bash
# Build the project
./scripts/dev.sh build    # Linux/macOS
.\scripts\dev.ps1 build   # Windows

# Run tests
./scripts/dev.sh test     # Linux/macOS
.\scripts\dev.ps1 test    # Windows

# Format code
./scripts/dev.sh format   # Linux/macOS
.\scripts\dev.ps1 format  # Windows

# Run linting checks
./scripts/dev.sh lint     # Linux/macOS
.\scripts\dev.ps1 lint    # Windows
```

## Project Structure

- `src/` - Source code
  - `parser.rs` - Code for parsing source languages
  - `ir.rs` - Intermediate representation definitions
  - `optimizer.rs` - IR optimization code
  - `generator.rs` - Code generation for target languages
  - `utils.rs` - Utility functions
  - `lib.rs` - Library interface
  - `main.rs` - Command-line interface
- `tests/` - Integration tests
- `examples/` - Example code
- `docs/` - Documentation
- `scripts/` - Development and utility scripts
  - `dev.sh` - Development script for Linux/macOS
  - `dev.ps1` - Development script for Windows
- `Dockerfile` - Production Docker image configuration
- `Dockerfile.dev` - Development Docker image configuration
- `docker-compose.yml` - Docker Compose configuration for development

## Coding Guidelines

- Follow the Rust style guide
- Write clear, descriptive comments
- Include tests for your code
- Keep functions small and focused
- Use meaningful variable and function names

## License

By contributing to this project, you agree that your contributions will be licensed under the project's license.
