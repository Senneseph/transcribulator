use transcribulator::convert;
use std::fs;
use std::path::Path;
use anyhow::Result;

fn main() -> Result<()> {
    // Example C code
    let c_code = r#"
    #include <stdio.h>
    
    int main() {
        printf("Hello, World!\n");
        return 0;
    }
    "#;
    
    // Convert C to Rust
    let rust_code = convert(c_code, "c", "rust")?;
    
    // Print the result
    println!("Original C code:\n{}\n", c_code);
    println!("Converted Rust code:\n{}", rust_code);
    
    // Save to file if examples directory exists
    let examples_dir = Path::new("examples/output");
    if !examples_dir.exists() {
        fs::create_dir_all(examples_dir)?;
    }
    
    fs::write(
        examples_dir.join("hello_world.rs"),
        rust_code
    )?;
    
    println!("\nSaved to examples/output/hello_world.rs");
    
    Ok(())
}
