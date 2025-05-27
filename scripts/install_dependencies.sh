#!/bin/bash
cd /home/ubuntu/nextjs-app

echo "Installing dependencies..."
npm install

echo "Building the Next.js app..."
npm run build

