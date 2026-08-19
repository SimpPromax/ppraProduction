# ============================================
# PPRA ADVISORY SERVICE - BACKEND
# Node.js + Express
# ============================================

FROM node:22-alpine

WORKDIR /app

# Copy dependency files first
COPY package.json package-lock.json ./

# Install production dependencies only
RUN npm ci --omit=dev

# Copy backend application
COPY server.js .
COPY proxy.js .
COPY in-memory-queue.js .
COPY email-queue.js .

# Backend port
EXPOSE 5000

# Production environment
ENV NODE_ENV=production

# Start server
CMD ["npm", "start"]