# Basic-Freedom Format: Core Principles

## Overview

The "basic-freedom" format is a set of principles and patterns for creating pure functional libraries in Rust that are optimized for WebAssembly. This document outlines the core principles of the format and provides guidelines for implementing libraries that adhere to these principles.

## Core Principles

### 1. Pure Functional Programming

#### Immutability

All data structures in the basic-freedom format are immutable by default. Mutation is explicit and controlled:

```rust
// Instead of this (mutation)
let mut vec = Vec::new();
vec.push(1);
vec.push(2);

// Do this (immutable construction)
let vec = Vector::empty()
    .push(1)
    .push(2);
```

#### Pure Functions

Functions should be pure, meaning they have no side effects and their output depends only on their inputs:

```rust
// Pure function
fn add(a: i32, b: i32) -> i32 {
    a + b
}

// Instead of this (impure function)
fn log_and_add(a: i32, b: i32) -> i32 {
    println!("Adding {} and {}", a, b); // Side effect
    a + b
}

// Do this (explicit effect)
fn log_and_add(a: i32, b: i32) -> (IO<()>, i32) {
    (IO::println(format!("Adding {} and {}", a, b)), a + b)
}
```

#### Referential Transparency

Expressions can be replaced with their values without changing the program's behavior:

```rust
// This should always be true for any function f and inputs x
let a = f(x);
let b = f(x);
assert_eq!(a, b);
```

### 2. Type Safety

#### Strong Static Typing

The basic-freedom format leverages Rust's strong static type system to prevent errors at compile time:

```rust
// Use specific types instead of generic ones
type UserId = NewType<String>;
type Email = NewType<String>;

// This prevents mixing up different string types
fn send_email(to: Email, message: String) -> IO<Result<(), Error>> {
    // ...
}

// This won't compile: send_email(UserId::new("user123"), "Hello");
```

#### Algebraic Data Types

Use algebraic data types to model domains:

```rust
enum UserStatus {
    Active,
    Inactive,
    Banned { reason: String },
}

struct User {
    id: UserId,
    email: Email,
    status: UserStatus,
}
```

#### Type-Driven Development

Design APIs around types first:

```rust
// Define the types
struct Task<T, E> {
    // ...
}

// Then implement operations on those types
impl<T, E> Task<T, E> {
    fn map<U>(self, f: impl Fn(T) -> U) -> Task<U, E> {
        // ...
    }
    
    fn flat_map<U>(self, f: impl Fn(T) -> Task<U, E>) -> Task<U, E> {
        // ...
    }
}
```

### 3. Composition

#### Function Composition

Build complex behavior by composing simple functions:

```rust
// Instead of this
fn process_data(data: &str) -> Result<i32, Error> {
    let parsed = parse(data)?;
    let validated = validate(parsed)?;
    let transformed = transform(validated)?;
    Ok(transformed)
}

// Do this
fn process_data(data: &str) -> Result<i32, Error> {
    parse(data)
        .and_then(validate)
        .and_then(transform)
}
```

#### Data Pipeline

Create data processing pipelines using composition:

```rust
let result = data
    .map(parse)
    .filter(is_valid)
    .map(transform)
    .fold(0, add);
```

#### Higher-Order Functions

Use functions that take or return other functions:

```rust
fn compose<A, B, C>(
    f: impl Fn(A) -> B,
    g: impl Fn(B) -> C,
) -> impl Fn(A) -> C {
    move |a| g(f(a))
}

let parse_and_validate = compose(parse, validate);
```

### 4. Effect Management

#### Explicit Effects

Make side effects explicit and controlled:

```rust
// Instead of this
fn save_user(user: User) -> Result<(), Error> {
    // Direct database access
    database::insert("users", user)?;
    Ok(())
}

// Do this
fn save_user(user: User) -> IO<Result<(), Error>> {
    IO::database_insert("users", user)
}
```

#### Effect Composition

Compose effects using monadic operations:

```rust
let program = IO::read_line()
    .flat_map(|line| IO::println(format!("You entered: {}", line)))
    .flat_map(|_| IO::random(1, 10))
    .flat_map(|n| IO::println(format!("Random number: {}", n)));
```

#### Effect Isolation

Isolate effects at the edges of the system:

```rust
// Pure core
fn business_logic(input: Input) -> Output {
    // Pure computation
}

// Effect wrapper
fn handler(request: Request) -> IO<Response> {
    IO::parse_request(request)
        .map(business_logic)
        .flat_map(IO::format_response)
}
```

### 5. WASM Optimization

#### Memory Efficiency

Design data structures to be memory efficient:

```rust
// Use compact representations
struct Point {
    x: f32,
    y: f32,
}

// Instead of
struct Point {
    x: f64,
    y: f64,
}
```

#### Minimal Allocations

Minimize allocations and copies:

```rust
// Instead of this
fn process(data: Vec<i32>) -> Vec<i32> {
    let mut result = Vec::new();
    for item in data {
        result.push(item * 2);
    }
    result
}

// Do this
fn process(data: &[i32]) -> impl Iterator<Item = i32> + '_ {
    data.iter().map(|&item| item * 2)
}
```

#### Code Size Optimization

Design for small code size:

```rust
// Use generics instead of multiple implementations
fn map<T, U>(option: Option<T>, f: impl FnOnce(T) -> U) -> Option<U> {
    match option {
        Some(value) => Some(f(value)),
        None => None,
    }
}

// Instead of
fn map_i32(option: Option<i32>, f: impl FnOnce(i32) -> i32) -> Option<i32> {
    match option {
        Some(value) => Some(f(value)),
        None => None,
    }
}

fn map_string(option: Option<String>, f: impl FnOnce(String) -> String) -> Option<String> {
    match option {
        Some(value) => Some(f(value)),
        None => None,
    }
}
```

## Core Data Structures

### Option<T>

Represents an optional value:

```rust
enum Option<T> {
    Some(T),
    None,
}

impl<T> Option<T> {
    fn map<U>(self, f: impl FnOnce(T) -> U) -> Option<U> {
        match self {
            Some(value) => Some(f(value)),
            None => None,
        }
    }
    
    fn and_then<U>(self, f: impl FnOnce(T) -> Option<U>) -> Option<U> {
        match self {
            Some(value) => f(value),
            None => None,
        }
    }
    
    // Other operations...
}
```

### Result<T, E>

Represents a computation that may fail:

```rust
enum Result<T, E> {
    Ok(T),
    Err(E),
}

impl<T, E> Result<T, E> {
    fn map<U>(self, f: impl FnOnce(T) -> U) -> Result<U, E> {
        match self {
            Ok(value) => Ok(f(value)),
            Err(error) => Err(error),
        }
    }
    
    fn and_then<U>(self, f: impl FnOnce(T) -> Result<U, E>) -> Result<U, E> {
        match self {
            Ok(value) => f(value),
            Err(error) => Err(error),
        }
    }
    
    // Other operations...
}
```

### Vector<T>

An immutable vector:

```rust
struct Vector<T> {
    // Internal implementation
}

impl<T> Vector<T> {
    fn empty() -> Self {
        // Create an empty vector
    }
    
    fn push(self, item: T) -> Self {
        // Create a new vector with the item added
    }
    
    fn map<U>(self, f: impl FnOnce(T) -> U) -> Vector<U> {
        // Create a new vector with the function applied to each element
    }
    
    // Other operations...
}
```

### Task<T, E>

Represents an asynchronous computation that may fail:

```rust
struct Task<T, E> {
    // Internal implementation
}

impl<T, E> Task<T, E> {
    fn succeed(value: T) -> Self {
        // Create a successful task
    }
    
    fn fail(error: E) -> Self {
        // Create a failed task
    }
    
    fn map<U>(self, f: impl FnOnce(T) -> U) -> Task<U, E> {
        // Create a new task with the function applied to the result
    }
    
    fn and_then<U>(self, f: impl FnOnce(T) -> Task<U, E>) -> Task<U, E> {
        // Create a new task that runs this task and then the function
    }
    
    // Other operations...
}
```

### IO<T>

Represents a computation with side effects:

```rust
struct IO<T> {
    // Internal implementation
}

impl<T> IO<T> {
    fn pure(value: T) -> Self {
        // Create an IO action that returns the value
    }
    
    fn map<U>(self, f: impl FnOnce(T) -> U) -> IO<U> {
        // Create a new IO action with the function applied to the result
    }
    
    fn flat_map<U>(self, f: impl FnOnce(T) -> IO<U>) -> IO<U> {
        // Create a new IO action that runs this action and then the function
    }
    
    // Standard IO operations
    fn println(message: String) -> IO<()> {
        // Create an IO action that prints the message
    }
    
    fn read_line() -> IO<String> {
        // Create an IO action that reads a line from stdin
    }
    
    // Other operations...
}
```

## Coding Guidelines

### Naming Conventions

1. **Types**: Use PascalCase for type names
2. **Functions**: Use snake_case for function names
3. **Constants**: Use SCREAMING_SNAKE_CASE for constants
4. **Variables**: Use snake_case for variables
5. **Modules**: Use snake_case for module names

### Function Design

1. **Small and Focused**: Functions should do one thing and do it well
2. **Pure by Default**: Functions should be pure unless explicitly marked as effectful
3. **Explicit Parameters**: Avoid implicit parameters and global state
4. **Return Values**: Prefer returning values over mutating parameters

### Error Handling

1. **Use Result**: Use Result<T, E> for operations that may fail
2. **Custom Error Types**: Define custom error types for specific domains
3. **Error Context**: Include context in error messages
4. **No Panics**: Avoid panics in library code

### Documentation

1. **Function Documentation**: Document the purpose, parameters, and return value of each function
2. **Type Documentation**: Document the purpose and invariants of each type
3. **Examples**: Include examples for complex functions
4. **Edge Cases**: Document edge cases and how they are handled

## Conclusion

The basic-freedom format provides a set of principles and patterns for creating pure functional libraries in Rust that are optimized for WebAssembly. By following these principles, we can create libraries that are:

1. **Safe**: Leveraging Rust's type system to prevent errors
2. **Composable**: Building complex behavior from simple components
3. **Testable**: Pure functions are easy to test
4. **Maintainable**: Explicit effects and immutability make code easier to reason about
5. **Performant**: Optimized for WebAssembly target

These principles will guide the translation of existing JavaScript/TypeScript libraries to Rust, creating a new ecosystem of functional, WASM-optimized libraries.
