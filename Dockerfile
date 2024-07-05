# Use a base image with Node.js 16.x and Java
FROM node:20-alpine

# Install other necessary dependencies if needed
RUN apk add --no-cache ffmpeg supervisor

# Set up working directory for the bot
WORKDIR /usr/src/app

# Copy the bot files
COPY . .

# Install bot dependencies
RUN npm install
RUN npm run deploy

# Set up directory for Lavalink if needed
# Example:
# WORKDIR /usr/src/lavalink
# RUN curl -LO https://github.com/Frederikam/Lavalink/releases/download/3.3.2/Lavalink.jar
# COPY ./docker/application.yml /usr/src/lavalink/application.yml

# Expose any necessary ports if using Lavalink or other services
# Example:
EXPOSE 2333

# Command to start the bot or any other services
CMD ["node", "index.js"]
