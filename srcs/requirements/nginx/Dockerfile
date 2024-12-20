# Use Debian bullseye (penultimate stable version)
FROM debian:oldstable

# Install NGINX and OpenSSL for TLS
RUN apt-get update && apt-get install -y \
	nginx \
	openssl \
	&& rm -rf /var/lib/apt/lists/*

# Create the directory for the TLS key and certificate
RUN mkdir -p /etc/nginx/secrets
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/secrets/nginx.key \
	-out /etc/nginx/secrets/nginx.crt \
	-subj "/C=GB/ST=England/L=London/O=42/CN=${DOMAIN_NAME}"
 
# Copy the Nginx configuration file into the container
COPY conf/default.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]


# //to test internet connection
# apt-get install -y iputils-ping
# ping -c 4 google.com
# ping 8.8.8.8

# //to test TLS version
# openssl s_client -connect localhost:443 -tls1_3