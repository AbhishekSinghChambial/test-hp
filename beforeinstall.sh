#!/bin/bash
set -e  # Exit on error

echo "===== Starting BeforeInstall Script ====="

APP_DIR="/var/www/hp-connect-web"
BACKUP_DIR="/mnt/hp-connect-web"

# Create necessary directories
mkdir -p "$APP_DIR"
mkdir -p "$BACKUP_DIR"

# Backup only if there are files inside the app directory
if [ "$(ls -A "$APP_DIR" 2>/dev/null)" ]; then
    echo "Backing up existing application files..."
    cp -r "$APP_DIR"/* "$BACKUP_DIR"/
else
    echo "No application files to back up. Skipping backup."
fi

# Clean the existing deployment directory (after backup)
rm -rf "$APP_DIR"/* || true

# Install NVM if not already installed
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

# Ensure permissions for NVM directory
chmod -R 755 "$NVM_DIR"

echo "===== BeforeInstall Script Completed ====="

