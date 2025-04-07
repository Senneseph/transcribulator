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

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/transcribulator.git
   cd transcribulator
   ```

2. Build the project:
   ```bash
   cargo build
   ```

3. Run the tests:
   ```bash
   cargo test
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

## Coding Guidelines

- Follow the Rust style guide
- Write clear, descriptive comments
- Include tests for your code
- Keep functions small and focused
- Use meaningful variable and function names

## License

By contributing to this project, you agree that your contributions will be licensed under the project's license.
