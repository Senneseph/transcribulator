use transcribulator::{convert, parser, ir, optimizer, generator};
use anyhow::Result;

#[test]
fn test_c_to_rust_conversion() -> Result<()> {
    let c_code = r#"
    #include <stdio.h>
    
    int main() {
        printf("Hello, World!\n");
        return 0;
    }
    "#;
    
    let result = convert(c_code, "c", "rust")?;
    
    // For now, just check that we got some output
    assert!(!result.is_empty());
    assert!(result.contains("Hello"));
    
    Ok(())
}

#[test]
fn test_ir_creation() {
    let ir = ir::IR::new("c");
    assert_eq!(ir.source_language, "c");
    assert!(ir.root.is_none());
}

#[test]
fn test_parser_unsupported_language() {
    let result = parser::parse("code", "unsupported");
    assert!(result.is_err());
}

#[test]
fn test_generator_unsupported_language() {
    let ir = ir::IR::new("c");
    let result = generator::generate(&ir, "unsupported");
    assert!(result.is_err());
}
