#!/bin/bash

# n8n Workflow Setup Script
set -e

echo "🚀 Setting up n8n workflow..."

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ This setup is designed for macOS only"
    exit 1
fi

# Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Docker if not present
if ! command -v docker &> /dev/null; then
    echo "🐳 Installing Docker Desktop..."
    brew install --cask docker
    echo "⚠️  Please start Docker Desktop manually: open -a Docker"
    echo "   Then run this script again: ./setup.sh"
    exit 1
fi

# Install Node.js if not present
if ! command -v node &> /dev/null; then
    echo "📦 Installing Node.js..."
    brew install node
fi

# Install pnpm if not present
if ! command -v pnpm &> /dev/null; then
    echo "📦 Installing pnpm..."
    npm install -g pnpm
fi

# Check if Docker is running
if ! docker info &> /dev/null; then
    echo "❌ Docker is not running"
    echo "⚠️  Please start Docker Desktop: open -a Docker"
    echo "   Then run this script again: ./setup.sh"
    exit 1
fi

# Check Docker Hub authentication
echo "🔐 Checking Docker Hub access..."
if ! docker pull hello-world > /dev/null 2>&1; then
    echo "⚠️  Docker Hub authentication required"
    echo "   Please run: docker login"
    echo "   Then run this script again: ./setup.sh"
    exit 1
fi

# Install dependencies
echo "📦 Installing dependencies..."
pnpm install

# Update docker-compose.yml with user's screenshot path
echo "🔧 Configuring screenshot path..."
SCREENSHOT_PATH=$(grep SCREENSHOT_PATH config.env | cut -d'=' -f2)
if [[ -n "$SCREENSHOT_PATH" && -d "$SCREENSHOT_PATH" ]]; then
    # Replace placeholder with actual path
    sed -i.bak "s|SCREENSHOT_PATH_PLACEHOLDER|$SCREENSHOT_PATH|g" docker-compose.yml
    echo "✅ Screenshot path configured: $SCREENSHOT_PATH (read-write access)"
else
    echo "⚠️  Warning: Screenshot path not found or invalid: $SCREENSHOT_PATH"
    echo "   Please check your config.env file"
fi

echo ""
echo "✅ Setup complete!"
echo "🚀 Starting n8n..."
pnpm start
echo "📋 n8n is now running at: http://localhost:5678"
