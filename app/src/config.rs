pub mod config {
    use serde::{Deserialize, Serialize};

    #[derive(Deserialize, Serialize)]
    pub struct TranscribulatorConfig {
        pub source: SourceConfig,
        pub target: TargetConfig,
        pub optimizations: OptimizationConfig,
    }

    #[derive(Deserialize, Serialize)]
    pub struct SourceConfig {
        pub language: Language,
        pub framework: Option<Framework>,
        pub patterns: Vec<Pattern>,
    }

    #[derive(Deserialize, Serialize)]
    pub struct TargetConfig {
        pub format: TargetFormat,
        pub compatibility: Vec<Compatibility>,
        pub optimizations: Vec<Optimization>,
    }
}
