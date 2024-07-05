# Use a base image with Node.js 16.x and Java
FROM node:18-alpine

# Install other necessary dependencies if needed
RUN apk add --no-cache ffmpeg supervisor

# Set up working directory for the bot
WORKDIR /usr/src/app

# Copy the bot files
COPY . .

# Install bot dependencies
RUN npm install


# Expose any necessary ports if using Lavalink or other services
# Example:
EXPOSE 2333

# Command to start the bot or any other services
CMD ["node", "index.js"]
