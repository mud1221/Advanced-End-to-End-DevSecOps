# ===========================
# Stage 1 - Install Dependencies
# ===========================
FROM node:20-alpine AS builder

# Create application directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application source
COPY . .

# ===========================
# Stage 2 - Production Runtime
# ===========================
FROM node:20-alpine

# Create application directory
WORKDIR /app

# Copy application from builder
COPY --from=builder /app .

# Environment
ENV NODE_ENV=production

# Backend port
EXPOSE 3500

# Start application
CMD ["node", "index.js"]