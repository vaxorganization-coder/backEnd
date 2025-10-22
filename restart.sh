#!/bin/bash

# Quick restart script for Vax Vaquinha Backend
# Usage: ./restart.sh

set -e

echo "🔄 Restarting Vax Backend..."

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_status "Restarting PM2 process..."
pm2 restart vax-backend

print_success "Application restarted successfully!"
print_status "Use 'pm2 logs vax-backend' to view logs"
