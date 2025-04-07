use serde::{Serialize, Deserialize};

/// Intermediate Representation (IR) for code
///
/// This structure represents the parsed code in a language-agnostic format
/// that can be optimized and then used to generate code in the target language.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct IR {
    /// The source language
    pub source_language: String,
    
    /// The root node of the AST
    pub root: Option<Node>,
}

impl IR {
    /// Create a new IR with the specified source language
    pub fn new(source_language: &str) -> Self {
        Self {
            source_language: source_language.to_string(),
            root: None,
        }
    }
}

/// A node in the abstract syntax tree
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Node {
    /// The type of node
    pub node_type: NodeType,
    
    /// Child nodes
    pub children: Vec<Node>,
    
    /// Additional attributes specific to the node type
    pub attributes: serde_json::Value,
}

/// Types of nodes in the abstract syntax tree
#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum NodeType {
    /// A program (root node)
    Program,
    
    /// A function declaration
    Function,
    
    /// A variable declaration
    Variable,
    
    /// A type declaration (struct, class, enum, etc.)
    Type,
    
    /// A statement
    Statement,
    
    /// An expression
    Expression,
    
    /// A literal value
    Literal,
    
    /// An identifier
    Identifier,
    
    /// A comment
    Comment,
}
