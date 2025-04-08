# Transcribulator

A tool for converting code between languages, focusing on C/C++/Python to Rust and Rust to WebAssembly.

## Overview

Transcribulator is a modular pipeline for code conversion between different programming languages. The primary focus is on converting C, C++, and Python code to Rust, and then potentially to WebAssembly for browser-based execution.

## Architecture

Transcribulator consists of several components:

### Core Conversion Pipeline

The conversion process follows a pipeline architecture:

```
source_code -> parser -> IR -> optimizer -> generator -> target_code
```

- **Parser**: Converts source code into an Intermediate Representation (IR)
- **IR**: A language-agnostic representation of the code
- **Optimizer**: Applies optimizations to the IR
- **Generator**: Converts the IR into the target language

### Web Interface

A browser-based interface for interacting with the Transcribulator conversion tools:

- Upload source code files for conversion
- Select source and target languages
- View and download converted code
- Syntax highlighting for code display

### Protocol Handler

Enables integration with the operating system:

- Register `transcribulator://` protocol with the operating system
- Discover and communicate with Transcribulator services
- Enable deep linking from external applications

## Supported Conversions

- C to Rust
- C++ to Rust
- Python to Rust
- Rust to WebAssembly

## Getting Started

### Prerequisites

- Docker
- Docker Compose
- Git

### Development Environment

Transcribulator uses Docker for development to ensure a consistent environment across all platforms. This approach eliminates the need to install Rust or any other dependencies locally.

```bash
# Clone the repository
git clone https://github.com/yourusername/transcribulator.git
cd transcribulator

# Start the development environment
./scripts/dev.sh up    # Linux/macOS
.\scripts\dev.ps1 up   # Windows

# Open a shell in the development container
./scripts/dev.sh shell    # Linux/macOS
.\scripts\dev.ps1 shell   # Windows
```

### Common Development Tasks

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

### Usage

#### Command Line

```bash
# Using Docker
docker run --rm -v $(pwd):/data transcribulator --input /data/input_file.c --output /data/output_file.rs --source-lang c --target-lang rust

# From development container
cargo run -- --input input_file.c --output output_file.rs --source-lang c --target-lang rust
```

#### Web Interface

```bash
# Start the web interface
docker-compose up web

# Access the web interface in your browser
open http://localhost:8080
```

#### Protocol Handler

Once the protocol handler is registered, you can use deep links to interact with Transcribulator:

```
transcribulator://convert?source=c&target=rust&file=example.c
```

## Development Status

This project is in the early stages of development. The current focus is on:

1. Researching existing tools for each conversion path
2. Designing the intermediate representation (IR) format
3. Implementing the basic pipeline architecture
4. Developing the web interface for easier interaction
5. Creating the protocol handler for system integration

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
