# Use Debian Oldstable as base image
FROM debian:oldstable

# Install MariaDB server
RUN apt-get update && apt-get install -y \
	iputils-ping \
	mariadb-server \
	&& rm -rf /var/lib/apt/lists/*

# Copy the custom entrypoint script into the container
COPY ./tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint to the custom script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Run MariaDB by default
CMD ["mysqld_safe"]
