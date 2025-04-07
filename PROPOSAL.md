We want to be able to take C, C++ and other low-level access libraries and paradigms and pass them through an automated conversion process ("transcribulator") to convert them to 100% Rust where possible.

We also want to be able to do this for other languages, starting with Python and focusing on ML-related libraries. So we can get performance of low level with the flexibility of a safe high level language.

While we do want to port to Rust, once there, we want to be able to convert to WebAssembly for portability, because we'll have an in-browser framework that can do this like a JIT-style, dynamically.

Of course there maybe some existing tools, let's research first.

1.) Convert C to Rust
2.) Convert C++ to Rust
3.) Convert Python to Rust
4.) Convert ML to Rust
5.) Convert Rust to WebAssembly
6.) Research existing tools
7.) Propose new toolchain
8.) We want to pin to and standardize on LTS, or production ready latest versions.
9.) Single soure of truth
10.) Automatic semantic versioning with meta versioning. Meta versioning is when nothing changes with the /dist, but the project itself may be cleaned up (housekeeping, technical debt).
11.) We do our work in Docker containers. local environment only needs to have the project (git) and to run Docker (docker-compose up)