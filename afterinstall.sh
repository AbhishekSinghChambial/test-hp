#!/bin/bash
set -e

APP_NAME="hp-connect-web"
APP_DIR="/var/www/$APP_NAME"
PORT=3000

echo "===== Starting AfterInstall Script ====="

# Load NVM
export NVM_DIR="/root/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
    nvm use 22
else
    echo "ERROR: NVM not found"
    exit 1
fi

# Navigate to the app directory
cd "$APP_DIR" || exit 1

# Copy production environment file
if [ -f ".env.production" ]; then
    cp .env.production .env.local
else
    echo "Warning: .env.production not found"
    touch .env.local
fi

# Kill any process already using the port
fuser -k $PORT/tcp || echo "No process was using port $PORT"

# Reinstall node dependencies cleanly
rm -rf node_modules package-lock.json
npm install --production

# Stop existing PM2 process if running
pm2 stop "$APP_NAME" || true
pm2 delete "$APP_NAME" || true

echo "===== AfterInstall Script Completed ====="

