# Vulnerabilities are not important as image is only used in build stage
FROM node:25-alpine AS builder

ARG PNPM_VERSION=latest-10

# Get node + pnpm
RUN npm install -g pnpm@${PNPM_VERSION}
# FROM alpine:latest AS builder
# RUN apk add --no-cache nodejs
# RUN wget -qO /bin/pnpm "https://github.com/pnpm/pnpm/releases/download/${PNPM_VERSION}/pnpm-linuxstatic-x64" && chmod +x /bin/pnpm

WORKDIR /app

# Build frontend
COPY package*.json *-lock* ./
RUN pnpm install --prod=false
COPY . ./
RUN pnpm build

# TODO: Get keys for JWT signing on startup
# CMD [ "node", "build/index.js" ]