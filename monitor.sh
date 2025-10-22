#!/bin/bash

# Monitoring script for Vax Vaquinha Backend
# Usage: ./monitor.sh [logs|status|restart|stop]

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

case "${1:-status}" in
    "logs")
        echo "📋 Showing application logs..."
        pm2 logs vax-backend
        ;;
    "status")
        echo "📊 Application status:"
        pm2 status
        ;;
    "restart")
        echo "🔄 Restarting application..."
        pm2 restart vax-backend
        print_success "Application restarted!"
        ;;
    "stop")
        echo "⏹️ Stopping application..."
        pm2 stop vax-backend
        print_success "Application stopped!"
        ;;
    "start")
        echo "▶️ Starting application..."
        pm2 start vax-backend
        print_success "Application started!"
        ;;
    *)
        echo "Usage: $0 {logs|status|restart|stop|start}"
        echo ""
        echo "Commands:"
        echo "  logs    - Show application logs"
        echo "  status  - Show PM2 status"
        echo "  restart - Restart the application"
        echo "  stop    - Stop the application"
        echo "  start   - Start the application"
        exit 1
        ;;
esac
