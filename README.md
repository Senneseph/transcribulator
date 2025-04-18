# Transcribulator

A tool for translating existing libraries into the "basic-freedom" format with pure functional style, targeting WebAssembly.

## Overview

Transcribulator is a modular pipeline for translating existing libraries into a pure functional Rust implementation optimized for WebAssembly. The current focus is on translating JavaScript/TypeScript libraries to Rust, starting with IMS Prime as a case study.

## Architecture

Transcribulator consists of several components:

### Analysis Pipeline

The analysis process follows a pipeline architecture:

```text
library -> dependency_mapper -> pattern_extractor -> functional_analyzer -> translation_planner
```

- **Dependency Mapper**: Analyzes the library's dependencies and structure
- **Pattern Extractor**: Identifies common patterns and abstractions
- **Functional Analyzer**: Analyzes code for functional equivalents
- **Translation Planner**: Creates a plan for translating to Rust

### Translation Pipeline

The translation process follows a pipeline architecture:

```text
translation_plan -> rust_generator -> wasm_optimizer -> typescript_bridge_generator
```

- **Rust Generator**: Generates pure functional Rust code
- **WASM Optimizer**: Optimizes the Rust code for WebAssembly
- **TypeScript Bridge Generator**: Generates TypeScript bindings

### Core Library

A set of fundamental data structures and utilities implemented in pure functional Rust:

- **Data Structures**: Option, Result, Vector, Map, etc.
- **Functional Utilities**: map, filter, fold, etc.
- **Effect Management**: IO, Task, etc.
- **WASM Bridge**: Utilities for WebAssembly integration

## Supported Conversions

- JavaScript/TypeScript to Rust (current focus)
- C to Rust (planned)
- C++ to Rust (planned)
- Python to Rust (planned)
- Rust to WebAssembly

## Basic-Freedom Format

The "basic-freedom" format is a set of principles and patterns for creating pure functional libraries in Rust that are optimized for WebAssembly:

- **Pure Functional**: Emphasizing immutability, composition, and side-effect management
- **Type-Safe**: Leveraging Rust's powerful type system
- **Composable**: Building complex behavior from simple components
- **Effect-Aware**: Making side effects explicit and controlled
- **WASM-Optimized**: Designed from the ground up for WebAssembly performance

## Current Focus: IMS Prime

The initial focus of Transcribulator is to decompose and analyze IMS Prime, mapping its dependencies and core functionalities to serve as a blueprint for the translation process.

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

#### Analyzing JavaScript/TypeScript Libraries

```bash
# Using Docker
docker run --rm -v $(pwd):/data transcribulator analyze --input /data/library --output /data/analysis

# From development container
cargo run -- analyze --input library --output analysis
```

#### Generating Dependency Graphs

```bash
# Using Docker
docker run --rm -v $(pwd):/data transcribulator deps --input /data/library --output /data/deps.dot

# From development container
cargo run -- deps --input library --output deps.dot
```

#### Translating to Rust

```bash
# Using Docker
docker run --rm -v $(pwd):/data transcribulator translate --input /data/library --output /data/rust-lib --format basic-freedom

# From development container
cargo run -- translate --input library --output rust-lib --format basic-freedom
```

#### Generating TypeScript Bindings

```bash
# Using Docker
docker run --rm -v $(pwd):/data transcribulator bindings --input /data/rust-lib --output /data/ts-types

# From development container
cargo run -- bindings --input rust-lib --output ts-types
```

## Development Status

This project is in active development. The current focus is on:

1. Implementing dependency mapping tools for JavaScript/TypeScript libraries
2. Developing pattern recognition for common JavaScript patterns
3. Creating a functional core identification methodology
4. Implementing IMS Prime decomposition and analysis
5. Designing pure functional Rust equivalents for common JS patterns
6. Creating WASM optimization strategies
7. Developing TypeScript bindings generation

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
