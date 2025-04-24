//! WASM Safety Guidelines for the Transcribulator
//!
//! This module provides guidelines and utilities for ensuring WASM compatibility
//! and optimizing WASM boundary crossings.

/// Memory management guidelines for WASM
pub mod memory_management {
    /// Prefer Vec/Array-based structures over linked lists
    pub fn prefer_contiguous_memory() -> &'static str {
        "Use Vec/Array-based structures over linked lists for better WASM performance"
    }
    
    /// Implement custom allocators when needed
    pub fn custom_allocators() -> &'static str {
        "Consider implementing custom allocators for specific memory patterns"
    }
    
    /// Be careful with recursive algorithms
    pub fn avoid_recursion() -> &'static str {
        "Be careful with recursive algorithms in WASM context, prefer iterative solutions"
    }
}

/// Type system considerations for WASM
pub mod type_system {
    /// Ensure types are WASM-compatible
    pub fn ensure_wasm_compatibility() -> &'static str {
        "Ensure all types are WASM-compatible and can be serialized across the boundary"
    }
    
    /// Use #[wasm_bindgen] carefully
    pub fn wasm_bindgen_usage() -> &'static str {
        "Use #[wasm_bindgen] carefully and consider its implications on memory and performance"
    }
    
    /// Consider JS/TS interop requirements
    pub fn js_interop() -> &'static str {
        "Consider JavaScript/TypeScript interop requirements when designing types"
    }
}

/// Error handling in WASM context
pub mod error_handling {
    /// Use Result type consistently
    pub fn use_result_type() -> &'static str {
        "Use Result type consistently for error handling in WASM context"
    }
    
    /// Avoid panics in WASM context
    pub fn avoid_panics() -> &'static str {
        "Avoid panics in WASM context as they can lead to unexpected behavior"
    }
    
    /// Proper error propagation across WASM boundary
    pub fn error_propagation() -> &'static str {
        "Implement proper error propagation across WASM boundary"
    }
}

/// Performance patterns for WASM
pub mod performance {
    /// Batch operations to minimize boundary crossings
    pub fn batch_operations() -> &'static str {
        "Batch operations to minimize WASM boundary crossings"
    }
    
    /// Use WASM linear memory effectively
    pub fn linear_memory() -> &'static str {
        "Use WASM linear memory effectively for better performance"
    }
    
    /// Implement proper tail-call optimization
    pub fn tail_call_optimization() -> &'static str {
        "Implement proper tail-call optimization for recursive functions"
    }
    
    /// Consider SIMD operations where available
    pub fn simd_operations() -> &'static str {
        "Consider SIMD operations where available for better performance"
    }
}

/// Trait for types that can be safely used in WASM context
pub trait WasmSafe {
    /// Check if the type is WASM-safe
    fn is_wasm_safe(&self) -> bool;
    
    /// Get suggestions for making the type WASM-safe
    fn wasm_safety_suggestions(&self) -> Vec<String>;
}
