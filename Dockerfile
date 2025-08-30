FROM node:22.12.0-alpine3.19@sha256:40dc4b415c17b85bea9be05314b4a753f45a4e1716bb31c01182e6c53d51a654
USER 0:0

# Enable corepack and pnpm, install git
RUN corepack enable \
    && corepack enable pnpm \
    && apk add --no-cache git \
    && git config --add --system safe.directory /mermaid

# Set max memory for Node.js
ENV NODE_OPTIONS="--max_old_space_size=8192"

# Working directory inside container
WORKDIR /mermaid

# Copy project files into container
COPY . .

# Install dependencies using pnpm
RUN pnpm install

# Build the Mermaid Live Editor (if needed)
RUN pnpm run build

# Expose port 8080 for Mermaid Live Editor
EXPOSE 8080

# Set environment PORT variable to 8080 (Railway will override this anyway)
ENV PORT=8080

# Start the Mermaid Live Editor server
CMD ["pnpm", "start"]
