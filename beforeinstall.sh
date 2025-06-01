#!/bin/bash
set -e  # Exit on any command failure

echo "===== Starting BeforeInstall Script ====="

APP_DIR="/var/www/hp-connect-web"

# Create the application directory if it doesn't exist
mkdir -p "$APP_DIR"

# Clean the existing deployment directory
rm -rf "$APP_DIR"/* || true

# Install NVM (Node Version Manager) if not installed
export NVM_DIR="/root/.nvm"
if [ ! -d "$NVM_DIR" ]; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# Load NVM
if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
else
    echo "ERROR: NVM not found"
    exit 1
fi

# Install and use Node.js v22
nvm install 22 || true
nvm alias default 22
nvm use 22

# Ensure permissions are set for NVM
chmod -R 755 "$NVM_DIR"

echo "===== BeforeInstall Script Completed ====="

