#!/bin/bash
set -e

mkdir -p /data/.openclaw /data/workspace

if [ ! -f /data/.openclaw/openclaw.json ]; then
  echo "No config found. Copying default config..."
  cp /app/openclaw.json /data/.openclaw/openclaw.json
fi

chown -R openclaw:openclaw /data

export OPENCLAW_STATE_DIR=/data/.openclaw
export OPENCLAW_WORKSPACE_DIR=/data/workspace
export HOME=/home/openclaw
export NODE_OPTIONS="--max-old-space-size=1024"

exec su -s /bin/bash openclaw -c "node $NODE_OPTIONS /app/src/server.js"
