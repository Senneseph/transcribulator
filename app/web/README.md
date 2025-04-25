# Transcribulator Web Interface

This directory contains the web interface for the Transcribulator project. It provides a user-friendly way to interact with the Transcribulator conversion tools.

## Features

- Upload source code files for conversion
- Select source and target languages
- View and download converted code
- Syntax highlighting for code display
- Real-time conversion status updates

## Development

### Prerequisites

- Node.js 20.x or later
- npm 10.x or later

### Setup

```bash
# Install dependencies
npm install

# Start development server
npm run dev
```

### Building for Production

```bash
# Build for production
npm run build

# Preview production build
npm run serve
```

## Docker Development

The web interface is designed to be run in a Docker container as part of the Transcribulator development environment:

```bash
# Start the development environment
docker-compose up web
```

## Architecture

The web interface is built with:

- React 18
- TypeScript
- Vite
- React Router for navigation
- Axios for API communication

## Integration with Transcribulator

The web interface communicates with the Transcribulator API to perform code conversions. It sends source code and language specifications to the API and displays the converted code when ready.
