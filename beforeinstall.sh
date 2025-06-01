#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

echo "===== Starting BeforeInstall Script ====="

# Create necessary directories
mkdir -p /var/www/hp-connect-web           # App directory
mkdir -p /mnt/hp-connect-web               # Backup directory

# Backup existing deployment files if any
if [ "$(ls -A /var/www/hp-connect-web 2>/dev/null)" ]; then
    echo "Backing up existing application files..."
    cp -r /var/www/hp-connect-web/* /mnt/hp-connect-web/
fi

# Clean the existing deployment directory (after backup)
rm -rf /var/www/hp-connect-web/*

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

