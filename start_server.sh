#!/bin/bash
set -e

APP_NAME="hp-connect-web"
APP_DIR="/var/www/$APP_NAME"

echo "===== Starting Application via PM2 ====="

# Load NVM and switch to Node 22
export NVM_DIR="/root/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
    nvm use 22
else
    echo "ERROR: NVM not found"
    exit 1
fi

# Navigate to app directory
cd "$APP_DIR"

# Start the application with PM2
pm2 start npm --name "$APP_NAME" -- start

# Save PM2 process list
pm2 save

# Note: Do NOT run 'pm2 startup' on every deploy. Run it once manually:
# pm2 startup systemd -u root --hp /root

echo "===== Application $APP_NAME is running via PM2 ====="

