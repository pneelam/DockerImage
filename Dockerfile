# Base image
# Stage 1: build
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY tsconfig.json ./
COPY src ./src

RUN npm run build

# Stage 2: run
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
# ollama run llama3 Start
RUN npm install --production

# Copy the rest of the code
COPY . .

# Expose app port
EXPOSE 8000

# Command to run
CMD ["npm", "start"]