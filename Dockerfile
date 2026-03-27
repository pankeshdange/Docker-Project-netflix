# Build stage
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the application
RUN npm run build

# Production stage
FROM node:18-alpine

WORKDIR /app

# Install serve to run the static files
RUN npm install -g serve

# Copy built files from builder stage
COPY --from=builder /app/dist ./dist

# Create a simple server configuration
EXPOSE 3000

# Serve the static files
CMD ["serve", "-s", "dist", "-l", "3000"]
