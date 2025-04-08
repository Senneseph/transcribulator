# Transcribulator Examples

This directory contains example files for testing the Transcribulator conversion process.

## Files

- `hello_world.c` - A simple C program
- `hello_world.py` - A simple Python program
- `hello_world.rs` - A simple Rust program

## Running Examples

### C to Rust

```bash
# Using Docker
docker run --rm -v $(pwd):/data transcribulator --input /data/examples/hello_world.c --output /data/examples/output/hello_world.rs --source-lang c --target-lang rust

# From source
cargo run -- --input examples/hello_world.c --output examples/output/hello_world.rs --source-lang c --target-lang rust
```

### Python to Rust

```bash
# Using Docker
docker run --rm -v $(pwd):/data transcribulator --input /data/examples/hello_world.py --output /data/examples/output/hello_world_py.rs --source-lang python --target-lang rust

# From source
cargo run -- --input examples/hello_world.py --output examples/output/hello_world_py.rs --source-lang python --target-lang rust
```

### Rust to WebAssembly

```bash
# Using Docker
docker run --rm -v $(pwd):/data transcribulator --input /data/examples/hello_world.rs --output /data/examples/output/hello_world.wasm --source-lang rust --target-lang wasm

# From source
cargo run -- --input examples/hello_world.rs --output examples/output/hello_world.wasm --source-lang rust --target-lang wasm
```

## Example Output

The output files will be placed in the `examples/output/` directory. This directory is ignored by Git, so you can freely experiment with different conversions without cluttering the repository.
