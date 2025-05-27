#!/bin/bash
cd /home/ubuntu/nextjs-app

echo "Restarting Next.js app with PM2..."
pm2 stop nextjs-app || true
pm2 start npm --name "nextjs-app" -- start

