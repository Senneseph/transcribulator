# Transcribulator Usage Guide

## Installation

### Using Docker (Recommended)

```bash
# Pull the Docker image
docker pull ghcr.io/yourusername/transcribulator:latest

# Or build it locally
git clone https://github.com/yourusername/transcribulator.git
cd transcribulator
docker build -t transcribulator .
```

### From Source

Transcribulator uses Docker for development to ensure a consistent environment:

```bash
# Clone the repository
git clone https://github.com/yourusername/transcribulator.git
cd transcribulator

# Build using Docker
docker-compose run --rm build
```

## Command Line Usage

### Using Docker

```bash
# Basic usage
docker run --rm -v $(pwd):/data transcribulator --input /data/input_file.c --output /data/output_file.rs --source-lang c --target-lang rust

# With verbose output
docker run --rm -v $(pwd):/data transcribulator --input /data/input_file.c --output /data/output_file.rs --source-lang c --target-lang rust --verbose
```

### From Source

```bash
# Basic usage
cargo run -- --input input_file.c --output output_file.rs --source-lang c --target-lang rust

# With verbose output
cargo run -- --input input_file.c --output output_file.rs --source-lang c --target-lang rust --verbose
```

## Supported Languages

### Source Languages
- C
- C++
- Python
- Rust

### Target Languages
- Rust
- WebAssembly

## Examples

### Converting C to Rust

```bash
# Using Docker
docker run --rm -v $(pwd):/data transcribulator --input /data/examples/hello_world.c --output /data/hello_world.rs --source-lang c --target-lang rust

# From source
cargo run -- --input examples/hello_world.c --output hello_world.rs --source-lang c --target-lang rust
```

### Converting Python to Rust

```bash
# Using Docker
docker run --rm -v $(pwd):/data transcribulator --input /data/examples/hello_world.py --output /data/hello_world.rs --source-lang python --target-lang rust

# From source
cargo run -- --input examples/hello_world.py --output hello_world.rs --source-lang python --target-lang rust
```

### Converting Rust to WebAssembly

```bash
# Using Docker
docker run --rm -v $(pwd):/data transcribulator --input /data/examples/hello_world.rs --output /data/hello_world.wasm --source-lang rust --target-lang wasm

# From source
cargo run -- --input examples/hello_world.rs --output hello_world.wasm --source-lang rust --target-lang wasm
```

## Using as a Library

You can also use Transcribulator as a library in your Rust projects:

```rust
use transcribulator::convert;
use std::fs;
use anyhow::Result;

fn main() -> Result<()> {
    // Read source code
    let source_code = fs::read_to_string("input_file.c")?;

    // Convert C to Rust
    let rust_code = convert(&source_code, "c", "rust")?;

    // Save the result
    fs::write("output_file.rs", rust_code)?;

    println!("Conversion complete!");

    Ok(())
}
```

## Development Status

Transcribulator is currently in early development. The current implementation provides a basic framework for code conversion, but many features are still being developed.

### Current Limitations

- Limited support for complex language features
- Placeholder implementations for many conversion paths
- No optimization of generated code

### Roadmap

1. Implement full C to Rust conversion
2. Add support for C++ to Rust conversion
3. Implement Python to Rust conversion
4. Add WebAssembly target support
5. Improve code optimization
