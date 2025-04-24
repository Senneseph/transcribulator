use anyhow::{Result, Context};
use std::fs;
use std::path::Path;

/// Read a file into a string
pub fn read_file(path: &str) -> Result<String> {
    fs::read_to_string(path).with_context(|| format!("Failed to read file: {}", path))
}

/// Write a string to a file
pub fn write_file(path: &str, content: &str) -> Result<()> {
    fs::write(path, content).with_context(|| format!("Failed to write file: {}", path))
}

/// Check if a file exists
pub fn file_exists(path: &str) -> bool {
    Path::new(path).exists()
}

/// Get the file extension from a path
pub fn get_file_extension(path: &str) -> Option<String> {
    Path::new(path)
        .extension()
        .and_then(|ext| ext.to_str())
        .map(|s| s.to_lowercase())
}

/// Infer the language from a file extension
pub fn infer_language_from_extension(extension: &str) -> Option<String> {
    match extension {
        "c" => Some("c".to_string()),
        "cpp" | "cc" | "cxx" | "h" | "hpp" => Some("cpp".to_string()),
        "py" => Some("python".to_string()),
        "rs" => Some("rust".to_string()),
        "wasm" => Some("webassembly".to_string()),
        _ => None,
    }
}
