FROM node:22-bookworm-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3 \
    build-essential \
    gosu \
    && rm -rf /var/lib/apt/lists/*

# Install pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Install OpenClaw globally
RUN npm install -g openclaw@latest

# Create app directory
WORKDIR /app

# Copy package files
COPY package.json pnpm-lock.yaml* ./

# Install dependencies
RUN pnpm install --frozen-lockfile 2>/dev/null || pnpm install

# Copy source
COPY . .

# Make entrypoint executable
RUN chmod +x entrypoint.sh

# Create non-root user for security
RUN groupadd -r openclaw && useradd -r -g openclaw -m openclaw

# Create data directory
RUN mkdir -p /data/.openclaw /data/workspace && \
    chown -R openclaw:openclaw /data /app

EXPOSE 8080

ENTRYPOINT ["./entrypoint.sh"]
