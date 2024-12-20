# Use Debian bullseye (penultimate stable version)
FROM debian:oldstable

# Install necessary packages
RUN apt-get update && apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    wget \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Create the /var/www/html directory
RUN mkdir -p /var/www/html

# Download and extract WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    rm latest.tar.gz && \
    mv wordpress/* /var/www/html && \
    rmdir wordpress
	
# Update the listen directive to allow connections on 0.0.0.0:9000
RUN sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /etc/php/7.4/fpm/pool.d/www.conf

# Create the socket directory
RUN mkdir -p /run/php

# Set the correct permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# # Add Redis caching configuration to wp-config.php
RUN sed -i "/\/\* Add any custom values between this line and the \"stop editing\" line. \*\//a \
define('WP_CACHE', true);\\n\
define('WP_REDIS_HOST', 'redis');\\n\
define('WP_REDIS_PORT', 6379);" /var/www/html/wp-config-sample.php

# Start PHP-FPM
ENTRYPOINT ["php-fpm7.4"]
CMD ["-F"]