# Use a base image with Node.js and Java
FROM openjdk:11-jre-slim

# Install Node.js and npm
RUN apt-get update && \
    apt-get install -y curl nodejs npm ffmpeg supervisor && \
    rm -rf /var/lib/apt/lists/*

# Set up working directory for the bot
WORKDIR /usr/src/app

# Copy the bot files
COPY . .

# Install bot dependencies
RUN npm install
RUN npm run deploy

# Set up directory for Lavalink
WORKDIR /usr/src/lavalink

# Download Lavalink
RUN curl -LO https://github.com/Frederikam/Lavalink/releases/download/3.3.2/Lavalink.jar

# Copy Lavalink configuration
COPY ./docker/application.yml /usr/src/lavalink/application.yml

# Expose Lavalink port
EXPOSE 2333

# Command to start supervisord
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
