FROM debian:oldstable

# Install Python3 and necessary tools
RUN apt-get update && apt-get install -y \
    python3 \
    # python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the static site files
COPY ./portafolio /app

# Run Python's built-in HTTP server
ENTRYPOINT ["python3"]
CMD ["-m", "http.server", "8000"]