#!/bin/bash

# Deploy script for Vax Vaquinha Backend
# Author: Generated for VPS deployment
# Usage: ./deploy.sh

set -e  # Exit on any error

echo "🚀 Starting deployment process..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
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

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    print_error "package.json not found. Please run this script from the project root directory."
    exit 1
fi

# Check if git is available
if ! command -v git &> /dev/null; then
    print_error "Git is not installed or not in PATH"
    exit 1
fi

# Check if npm is available
if ! command -v npm &> /dev/null; then
    print_error "npm is not installed or not in PATH"
    exit 1
fi

# Check if pm2 is available
if ! command -v pm2 &> /dev/null; then
    print_warning "PM2 is not installed. Installing PM2 globally..."
    npm install -g pm2
fi

print_status "Pulling latest changes from repository..."
git pull origin main

print_status "Installing dependencies..."
npm install

print_status "Generating Prisma client..."
npx prisma generate

print_status "Running database migrations..."
npx prisma migrate deploy

print_status "Stopping and removing existing PM2 process (if running)..."
if pm2 status vax-backend > /dev/null 2>&1; then
    pm2 stop vax-backend
    pm2 delete vax-backend
fi

print_status "Building the application..."
npm run build

print_status "Starting application with PM2..."
pm2 start npm --name "vax-backend" -- run start:prod

print_status "Saving PM2 configuration..."
pm2 save

print_status "Setting up PM2 startup script..."
pm2 startup

print_success "Deployment completed successfully!"
print_status "Application is running with PM2 process name: vax-backend"
print_status "Use 'pm2 status' to check the application status"
print_status "Use 'pm2 logs vax-backend' to view logs"
print_status "Use 'pm2 restart vax-backend' to restart the application"

# Show current status
echo ""
print_status "Current PM2 status:"
pm2 status
