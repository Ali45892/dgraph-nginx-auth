FROM dgraph/dgraph:v24.1.2

# Install nginx
USER root
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Copy our configuration files
COPY nginx.conf /app/nginx.conf
COPY start.sh /app/start.sh

# Make start script executable
RUN chmod +x /app/start.sh

# Expose port 8080 (nginx will listen on this)
EXPOSE 8080

# Use our start script
CMD ["/app/start.sh"]
