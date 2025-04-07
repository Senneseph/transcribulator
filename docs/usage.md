# Transcribulator Usage Guide

## Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/transcribulator.git
cd transcribulator

# Build the project
cargo build --release

# Install the binary (optional)
cargo install --path .
```

## Command Line Usage

```bash
# Basic usage
transcribulator --input input_file.c --output output_file.rs --source-lang c --target-lang rust

# With verbose output
transcribulator --input input_file.c --output output_file.rs --source-lang c --target-lang rust --verbose
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
transcribulator --input examples/hello_world.c --output hello_world.rs --source-lang c --target-lang rust
```

### Converting Python to Rust

```bash
transcribulator --input examples/hello_world.py --output hello_world.rs --source-lang python --target-lang rust
```

### Converting Rust to WebAssembly

```bash
transcribulator --input examples/hello_world.rs --output hello_world.wasm --source-lang rust --target-lang wasm
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
