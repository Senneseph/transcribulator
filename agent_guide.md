# AI Agent Guide for Transcribulator Project

## Phase 1: Research & Analysis

1. Survey existing tools for each conversion path:
   - C2Rust (<https://github.com/immunant/c2rust>)
   - CXX (<https://github.com/dtolnay/cxx>)
   - PyO3 (<https://github.com/PyO3/pyo3>)
   - wasm-pack (<https://github.com/rustwasm/wasm-pack>)

2. Analyze limitations and success rates of existing tools
3. Document common patterns and challenges in each conversion type

## Phase 2: Architecture Planning

1. Design modular pipeline architecture:

   ```rust
   source_code -> parser -> IR -> optimizer -> rust_generator
   ```

2. Define intermediate representation (IR) format
3. Plan validation and testing framework
4. Design WebAssembly integration strategy

## Phase 3: Implementation Priority

1. Start with C -> Rust (most mature tooling ecosystem)
2. Implement Python -> Rust (focus on ML libraries)
3. Add C++ -> Rust support
4. Develop Rust -> WebAssembly pipeline
5. Create browser-based JIT framework

## Phase 4: Standards & Versioning

1. Pin to specific versions:
   - Rust (latest stable)
   - LLVM (for C/C++ parsing)
   - Python (3.11+)
   - WebAssembly toolchain

## Key Considerations

1. Safety: Ensure generated Rust code maintains memory safety
2. Performance: Optimize IR for native Rust patterns
3. Maintainability: Generate readable, idiomatic Rust code
4. Testing: Implement behavior-preserving validation
5. Documentation: Auto-generate conversion documentation

## Success Metrics

1. Conversion success rate
2. Performance comparison with original code
3. Memory safety validation
4. Test coverage
5. Generated code maintainability score
