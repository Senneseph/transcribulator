# Transcribulator Protocol Handler

This directory contains the protocol handler for the Transcribulator project. It enables integration with the operating system by registering custom protocol handlers.

## Features

- Register `transcribulator://` protocol with the operating system
- Discover and communicate with Transcribulator services
- Provide service health monitoring

## Development

### Prerequisites

- Go 1.22 or later
- Docker (for running in a container)

### Setup

```bash
# Build the protocol handler
go build -o protocol-handler

# Run the protocol handler
./protocol-handler
```

### Docker Development

The protocol handler is designed to be run in a Docker container as part of the Transcribulator development environment:

```bash
# Start the development environment
docker-compose up protocol-handler
```

## Architecture

The protocol handler is built with:

- Go 1.22
- Docker API for service discovery
- Gorilla Mux for HTTP routing

## Integration with Transcribulator

The protocol handler enables deep linking to the Transcribulator application from external sources. For example:

- `transcribulator://convert?source=c&target=rust&file=example.c` - Open the Transcribulator web interface and start a conversion
- `transcribulator://open?file=example.rs` - Open a file in the Transcribulator editor

## Security Considerations

The protocol handler has access to the Docker socket, which is a privileged operation. In production environments, appropriate security measures should be implemented to restrict access to authorized users only.
