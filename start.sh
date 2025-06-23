#!/bin/bash

# Replace placeholder with actual API key from environment
sed -i "s/PLACEHOLDER_API_KEY/${API_KEY:-railway-dgraph-api-key-2025}/g" /app/nginx.conf

# Start nginx in background
nginx -c /app/nginx.conf &

# Create data directory (use the mounted volume path)
mkdir -p /dgraph

# Start DGraph Zero in background
dgraph zero --wal /dgraph/zw --my=0.0.0.0:5080 --replicas=1 &

# Wait for Zero to start
sleep 15

# Start DGraph Alpha on internal port 8081 (nginx will proxy from 8080)
dgraph alpha --postings /dgraph/p --wal /dgraph/w --zero=localhost:5080 --port_offset=1
