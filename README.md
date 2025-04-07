# Transcribulator

A tool for converting code between languages, focusing on C/C++/Python to Rust and Rust to WebAssembly.

## Overview

Transcribulator is a modular pipeline for code conversion between different programming languages. The primary focus is on converting C, C++, and Python code to Rust, and then potentially to WebAssembly for browser-based execution.

## Architecture

The conversion process follows a pipeline architecture:

```
source_code -> parser -> IR -> optimizer -> generator -> target_code
```

- **Parser**: Converts source code into an Intermediate Representation (IR)
- **IR**: A language-agnostic representation of the code
- **Optimizer**: Applies optimizations to the IR
- **Generator**: Converts the IR into the target language

## Supported Conversions

- C to Rust
- C++ to Rust
- Python to Rust
- Rust to WebAssembly

## Getting Started

### Prerequisites

- Rust (latest stable)
- Cargo

### Installation

```bash
git clone https://github.com/yourusername/transcribulator.git
cd transcribulator
cargo build --release
```

### Usage

```bash
cargo run -- --input input_file.c --output output_file.rs --source-lang c --target-lang rust
```

## Development Status

This project is in the early stages of development. The current focus is on:

1. Researching existing tools for each conversion path
2. Designing the intermediate representation (IR) format
3. Implementing the basic pipeline architecture

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
