#!/bin/bash
set -e

# Create the scripts directory if it doesn't exist
mkdir -p "$(dirname "$0")"

# Function to display help
show_help() {
    echo "Transcribulator Development Script"
    echo ""
    echo "Usage: ./scripts/dev.sh [command]"
    echo ""
    echo "Commands:"
    echo "  up          Start the development environment"
    echo "  down        Stop the development environment"
    echo "  shell       Open a shell in the development container"
    echo "  build       Build the project"
    echo "  test        Run tests"
    echo "  lint        Run linting checks"
    echo "  format      Format the code"
    echo "  clean       Clean build artifacts"
    echo "  web         Start the web interface"
    echo "  protocol    Start the protocol handler"
    echo "  all         Start all services"
    echo "  help        Show this help message"
    echo ""
}

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed or not in PATH"
    exit 1
fi

# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "Error: docker-compose is not installed or not in PATH"
    exit 1
fi

# Process commands
case "$1" in
    up)
        echo "Starting development environment..."
        docker-compose up -d dev
        ;;
    down)
        echo "Stopping development environment..."
        docker-compose down
        ;;
    shell)
        echo "Opening shell in development container..."
        docker-compose exec dev bash
        ;;
    build)
        echo "Building project..."
        docker-compose run --rm dev cargo build
        ;;
    test)
        echo "Running tests..."
        docker-compose run --rm test
        ;;
    lint)
        echo "Running linting checks..."
        docker-compose run --rm dev cargo clippy -- -D warnings
        ;;
    format)
        echo "Formatting code..."
        docker-compose run --rm dev cargo fmt
        ;;
    clean)
        echo "Cleaning build artifacts..."
        docker-compose run --rm dev cargo clean
        ;;
    web)
        echo "Starting web interface..."
        docker-compose up -d web
        echo -e "\e[36mWeb interface available at http://localhost:8080\e[0m"
        ;;
    protocol)
        echo "Starting protocol handler..."
        docker-compose up -d protocol-handler
        ;;
    all)
        echo "Starting all services..."
        docker-compose up -d
        echo -e "\e[36mWeb interface available at http://localhost:8080\e[0m"
        ;;
    help|*)
        show_help
        ;;
esac
