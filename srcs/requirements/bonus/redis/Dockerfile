FROM debian:oldstable

# Install Redis
RUN apt-get update && apt-get install -y \
	redis-server \
	&& rm -rf /var/lib/apt/lists/*

# Update Redis configuration to listen on all interfaces
RUN sed -i 's/^bind 127.0.0.1 ::1/bind 0.0.0.0/' /etc/redis/redis.conf && \
    sed -i 's/^daemonize yes/daemonize no/' /etc/redis/redis.conf

# Start Redis server
ENTRYPOINT ["redis-server"]
CMD ["/etc/redis/redis.conf"]

# cat <<EOL >> /var/www/html/wp-config.php
# /** Enable Redis caching */
# define('WP_CACHE', true);
# define('WP_REDIS_HOST', 'redis');
# define('WP_REDIS_PORT', 6379);
# EOL