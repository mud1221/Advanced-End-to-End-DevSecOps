# ==============================
# Stage 1 - Install Dependencies
# ==============================

FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install --omit=dev

COPY . .

# ==============================
# Stage 2 - Runtime
# ==============================

FROM node:20-alpine

WORKDIR /app

COPY --from=builder /app .

ENV NODE_ENV=production
ENV PORT=3500

EXPOSE 3500

CMD ["node", "index.js"]