# Vulnerabilities are not important as image is only used in build stage
# FROM alpine:latest AS builder
FROM node:25-alpine AS builder

ARG PNPM_VERSION=v10.32.1

# Get node + pnpm
# RUN apk add --no-cache nodejs
# RUN wget -qO /bin/pnpm "https://github.com/pnpm/pnpm/releases/download/${PNPM_VERSION}/pnpm-linuxstatic-x64" && chmod +x /bin/pnpm
RUN npm install -g pnpm@latest-10

WORKDIR /app

# Build frontend
COPY package*.json *-lock* ./
RUN pnpm install --prod=false
COPY . ./
RUN pnpm build

# TODO: Get keys for JWT signing on startup
# CMD [ "node", "build/index.js" ]