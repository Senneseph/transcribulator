# Transcribulator Documentation

This directory contains documentation for the Transcribulator project.

## Files

- `usage.md` - Detailed usage instructions for the Transcribulator tool
- `research.md` - Research on existing code conversion tools
- `roadmap.md` - Development roadmap for the Transcribulator project

## Development Philosophy

Transcribulator aims to expand the availability of high-quality Rust libraries by providing automated, machine-enabled translation from other languages. Our focus is on:

1. **Correctness**: Generated Rust code should maintain the same behavior as the original code
2. **Safety**: Generated Rust code should leverage Rust's safety features where possible
3. **Readability**: Generated Rust code should be idiomatic and maintainable
4. **Performance**: Generated Rust code should maintain or improve upon the performance of the original code

## Docker-Based Development

We use Docker for development to ensure a consistent environment across all platforms. This approach eliminates the need to install Rust or any other dependencies locally. The only requirements are:

- Docker
- Docker Compose
- Git

See the main README.md for instructions on setting up the development environment.
