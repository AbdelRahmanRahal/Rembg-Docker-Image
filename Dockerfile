# Use Python 3.11 (safe within >=3.10, <3.14 range according to rembg docs)
FROM python:3.11-slim

# Prevent interactive prompts during installs
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip & install rembg with CPU + CLI
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir "rembg[cpu,cli]"

# Set working directory
WORKDIR /app

# Default command runs rembg help
ENTRYPOINT ["rembg"]
CMD ["--help"]
