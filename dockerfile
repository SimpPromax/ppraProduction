# ============================================
# PPRA WEBSITE - FRONTEND
# React + Vite
# ============================================

# ---------- BUILD STAGE ----------
FROM node:22-alpine AS builder

WORKDIR /app

# Copy package files first for Docker layer caching
COPY package.json package-lock.json ./

# Install dependencies
RUN npm ci

# Copy frontend source
COPY . .

# Production build
RUN npm run build


# ---------- PRODUCTION STAGE ----------
FROM nginx:alpine

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy React/Vite production build
COPY --from=builder /app/dist /usr/share/nginx/html

# SPA configuration
COPY docker/nginx/frontend.conf /etc/nginx/conf.d/default.conf

# Expose HTTP
EXPOSE 80

# Nginx runs in foreground
CMD ["nginx", "-g", "daemon off;"]