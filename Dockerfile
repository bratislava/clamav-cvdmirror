FROM docker.io/python:3.9-alpine
ENV PYTHONUNBUFFERED 1

# Install Bash and Caddy
RUN apk add --no-cache bash caddy \
 && rm -rf /var/cache/apk/*

# Install CVD-Update
RUN pip install --no-cache-dir cvdupdate

# Copy Scripts
COPY health.sh /health.sh
COPY readiness.sh /readiness.sh
COPY entrypoint.sh /entrypoint.sh

# Set permissions
RUN chmod +x /health.sh
RUN chmod +x /readiness.sh
RUN chmod +x ./entrypoint.sh

# Start Server
EXPOSE 8080
CMD [ "./entrypoint.sh", "serve" ]