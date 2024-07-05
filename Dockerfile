# Use a base image with Node.js and Java
FROM openjdk:11-jre-slim

# Install Node.js
RUN apt-get update && apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_17.x | bash - && \
    apt-get install -y nodejs ffmpeg supervisor

# Set up working directory
WORKDIR /usr/src/app

# Copy bot files
COPY . .

# Install bot dependencies
RUN npm install
RUN npm run deploy

# Download Lavalink
WORKDIR /usr/src/lavalink
RUN curl -LO https://github.com/Frederikam/Lavalink/releases/download/3.3.2/Lavalink.jar

# Copy Lavalink configuration
COPY ./docker/application.yml /usr/src/lavalink/application.yml

# Copy supervisord configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose Lavalink port
EXPOSE 2333

# Command to start supervisord
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
