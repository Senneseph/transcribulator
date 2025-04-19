# Transcribulator Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                     Transcribulator System                                       │
└─────────────────────────────────────────────────────────────────────────────────────────────────┘
                                               │
                                               ▼
┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                      Source Code Repository                                      │
└─────────────────────────────────────────────────────────────────────────────────────────────────┘
                                               │
                                               ▼
┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                  Dependency Resolution System                                    │
│                                                                                                 │
│  ┌───────────────────────┐     ┌───────────────────────┐     ┌───────────────────────┐         │
│  │   Dependency Graph    │────▶│  Dependency Resolver  │────▶│  Translation Order    │         │
│  └───────────────────────┘     └───────────────────────┘     └───────────────────────┘         │
└─────────────────────────────────────────────────────────────────────────────────────────────────┘
                                               │
                                               ▼
┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                 Incremental Translation System                                   │
│                                                                                                 │
│  ┌───────────────────────┐     ┌───────────────────────┐     ┌───────────────────────┐         │
│  │    Chunk Scheduler    │────▶│     Source Chunks     │────▶│     Chunk Merger      │         │
│  └───────────────────────┘     └───────────────────────┘     └───────────────────────┘         │
└─────────────────────────────────────────────────────────────────────────────────────────────────┘
                                               │
                                               ▼
┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                      Analysis Pipeline                                           │
│                                                                                                 │
│  ┌───────────────────────┐     ┌───────────────────────┐     ┌───────────────────────┐         │
│  │  Pattern Recognition  │────▶│   Dependency Analysis │────▶│    Analysis Results   │         │
│  └───────────────────────┘     └───────────────────────┘     └───────────────────────┘         │
└─────────────────────────────────────────────────────────────────────────────────────────────────┘
                                               │
                                               ▼
┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                    Translation Pipeline                                          │
│                                                                                                 │
│  ┌───────────────────────┐     ┌───────────────────────┐     ┌───────────────────────┐         │
│  │  Translation Rules    │────▶│   Monadic Pipeline    │────▶│  Translation Results  │         │
│  └───────────────────────┘     └───────────────────────┘     └───────────────────────┘         │
│                                         ▲                                                       │
│                                         │                                                       │
│                                         │                                                       │
│  ┌───────────────────────────────────────────────────────┐                                     │
│  │                   Effect System                        │                                     │
│  │                                                        │                                     │
│  │  ┌───────────────┐    ┌───────────────┐               │                                     │
│  │  │  IO Effects   │    │ Effect Handlers│               │                                     │
│  │  └───────────────┘    └───────────────┘               │                                     │
│  └───────────────────────────────────────────────────────┘                                     │
│                                                                                                 │
│  ┌───────────────────────────────────────────────────────┐                                     │
│  │                 Metrics Collection                     │                                     │
│  │                                                        │                                     │
│  │  ┌───────────────┐    ┌───────────────┐               │                                     │
│  │  │  Collectors   │    │   Reporters   │               │                                     │
│  │  └───────────────┘    └───────────────┘               │                                     │
│  └───────────────────────────────────────────────────────┘                                     │
└─────────────────────────────────────────────────────────────────────────────────────────────────┘
                                               │
                                               ▼
┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                    Optimization Pipeline                                         │
│                                                                                                 │
│  ┌───────────────────────┐     ┌───────────────────────┐     ┌───────────────────────┐         │
│  │  WASM Optimizations   │────▶│  Memory Optimizations │────▶│ Performance Tuning    │         │
│  └───────────────────────┘     └───────────────────────┘     └───────────────────────┘         │
└─────────────────────────────────────────────────────────────────────────────────────────────────┘
                                               │
                                               ▼
┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                      Target Code Generation                                      │
└─────────────────────────────────────────────────────────────────────────────────────────────────┘
                                               │
                                               ▼
┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                  Bidirectional Mapping System                                    │
│                                                                                                 │
│  ┌───────────────────────┐     ┌───────────────────────┐     ┌───────────────────────┐         │
│  │  Reverse Translation  │◀───▶│   Fidelity Checking   │◀───▶│  Round-Trip Validation│         │
│  └───────────────────────┘     └───────────────────────┘     └───────────────────────┘         │
└─────────────────────────────────────────────────────────────────────────────────────────────────┘
```

This diagram illustrates the complete Transcribulator architecture with all the refinements integrated. The flow starts with the source code repository, proceeds through dependency resolution, incremental translation, analysis, translation with effects and metrics, optimization, and target code generation, with the option for bidirectional mapping for verification.

The key components are:

1. **Dependency Resolution System**: Analyzes dependencies and determines the correct translation order.
2. **Incremental Translation System**: Breaks down large codebases into manageable chunks.
3. **Analysis Pipeline**: Extracts patterns and analyzes the source code.
4. **Translation Pipeline**: Applies translation rules with effect handling and metrics collection.
5. **Optimization Pipeline**: Applies optimizations for WASM and performance.
6. **Bidirectional Mapping System**: Enables round-trip validation and verification.

Each component has its own subcomponents and responsibilities, working together to provide a comprehensive translation system.
