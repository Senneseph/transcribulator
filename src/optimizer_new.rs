use anyhow::Result;
use crate::ir::IR;
use crate::batch::{BatchProcessor, OperationQueue};

/// Optimize the intermediate representation
pub fn optimize(ir: &mut IR) -> Result<()> {
    // Apply general optimizations
    optimize_memory_layout(ir)?;
    optimize_wasm_boundary_crossings(ir)?;
    
    // Apply language-specific optimizations
    match ir.source_language.as_str() {
        "rust" => optimize_for_rust(ir)?,
        "wasm" | "webassembly" => optimize_for_wasm(ir)?,
        _ => {}
    }
    
    Ok(())
}

/// Apply Rust-specific optimizations to the IR
pub fn optimize_for_rust(ir: &mut IR) -> Result<()> {
    // Apply Rust-specific optimizations
    optimize_rust_iterators(ir)?;
    optimize_rust_error_handling(ir)?;
    
    Ok(())
}

/// Apply WebAssembly-specific optimizations to the IR
pub fn optimize_for_wasm(ir: &mut IR) -> Result<()> {
    // Apply WebAssembly-specific optimizations
    optimize_wasm_memory(ir)?;
    optimize_wasm_boundary_crossings(ir)?;
    optimize_wasm_error_handling(ir)?;
    
    Ok(())
}
