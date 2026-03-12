FROM node:18-slim

WORKDIR /app

# Copy content directory first (needed for prepublish script)
COPY content ./content

# Copy package files
COPY cli/package.json ./cli/

# Install production dependencies (skip prepublish script)
RUN cd cli && npm install --production --ignore-scripts

# Copy CLI source and binaries
COPY cli/bin ./cli/bin
COPY cli/src ./cli/src
COPY cli/skills ./cli/skills

# Make CLI binaries executable
RUN chmod +x cli/bin/chub cli/bin/chub-mcp

# Create non-root user
RUN useradd -m appuser
USER appuser

# Default command
CMD ["node", "cli/bin/chub", "--help"]
