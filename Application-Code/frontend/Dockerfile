# ===========================
# Stage 1 - Build React App
# ===========================
FROM node:20-alpine AS builder

# Create application directory
WORKDIR /app

# Copy dependency files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Backend URL
ARG REACT_APP_BACKEND_URL
ENV REACT_APP_BACKEND_URL=$REACT_APP_BACKEND_URL

# React build requirement
ENV NODE_OPTIONS=--openssl-legacy-provider

# Build production files
RUN npm run build

# ===========================
# Stage 2 - Nginx Runtime
# ===========================
FROM nginx:alpine

# Copy React build
COPY --from=builder /app/build /usr/share/nginx/html

# Expose HTTP port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]