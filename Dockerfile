FROM docker.io/python:3.9-alpine AS prod
ENV PYTHONUNBUFFERED 1
WORKDIR /

# Install Bash and Caddy
RUN apk add --no-cache bash caddy \
 && rm -rf /var/cache/apk/*

# Install CVD-Update
RUN pip install --no-cache-dir cvdupdate

# Copy config
COPY Caddyfile Caddyfile

# Copy Scripts
COPY health.sh health.sh
COPY entrypoint.sh entrypoint.sh

# Set permissions
RUN chmod +x ./health.sh
RUN chmod +x ./entrypoint.sh

# Start Server
EXPOSE 8080
