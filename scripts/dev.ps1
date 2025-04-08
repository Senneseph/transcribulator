# Transcribulator Development Script for Windows

# Function to display help
function Show-Help {
    Write-Host "Transcribulator Development Script"
    Write-Host ""
    Write-Host "Usage: .\scripts\dev.ps1 [command]"
    Write-Host ""
    Write-Host "Commands:"
    Write-Host "  up          Start the development environment"
    Write-Host "  down        Stop the development environment"
    Write-Host "  shell       Open a shell in the development container"
    Write-Host "  build       Build the project"
    Write-Host "  test        Run tests"
    Write-Host "  lint        Run linting checks"
    Write-Host "  format      Format the code"
    Write-Host "  clean       Clean build artifacts"
    Write-Host "  web         Start the web interface"
    Write-Host "  protocol    Start the protocol handler"
    Write-Host "  all         Start all services"
    Write-Host "  help        Show this help message"
    Write-Host ""
}

# Check if Docker is installed
try {
    docker --version | Out-Null
} catch {
    Write-Host "Error: Docker is not installed or not in PATH" -ForegroundColor Red
    exit 1
}

# Check if docker-compose is installed
try {
    docker-compose --version | Out-Null
} catch {
    Write-Host "Error: docker-compose is not installed or not in PATH" -ForegroundColor Red
    exit 1
}

# Process commands
switch ($args[0]) {
    "up" {
        Write-Host "Starting development environment..." -ForegroundColor Green
        docker-compose up -d dev
    }
    "down" {
        Write-Host "Stopping development environment..." -ForegroundColor Green
        docker-compose down
    }
    "shell" {
        Write-Host "Opening shell in development container..." -ForegroundColor Green
        docker-compose exec dev bash
    }
    "build" {
        Write-Host "Building project..." -ForegroundColor Green
        docker-compose run --rm dev cargo build
    }
    "test" {
        Write-Host "Running tests..." -ForegroundColor Green
        docker-compose run --rm test
    }
    "lint" {
        Write-Host "Running linting checks..." -ForegroundColor Green
        docker-compose run --rm dev cargo clippy -- -D warnings
    }
    "format" {
        Write-Host "Formatting code..." -ForegroundColor Green
        docker-compose run --rm dev cargo fmt
    }
    "clean" {
        Write-Host "Cleaning build artifacts..." -ForegroundColor Green
        docker-compose run --rm dev cargo clean
    }
    "web" {
        Write-Host "Starting web interface..." -ForegroundColor Green
        docker-compose up -d web
        Write-Host "Web interface available at http://localhost:8080" -ForegroundColor Cyan
    }
    "protocol" {
        Write-Host "Starting protocol handler..." -ForegroundColor Green
        docker-compose up -d protocol-handler
    }
    "all" {
        Write-Host "Starting all services..." -ForegroundColor Green
        docker-compose up -d
        Write-Host "Web interface available at http://localhost:8080" -ForegroundColor Cyan
    }
    default {
        Show-Help
    }
}
