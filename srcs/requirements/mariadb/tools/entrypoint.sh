#!/bin/bash
set -e

# Ensure MariaDB environment is clean 
rm -rf /var/run/mysqld/* 
mkdir -p /var/run/mysqld 
chown mysql:mysql /var/run/mysqld

sed -i "s/^bind-address\s*=.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

# Start the MariaDB server in the background
mysqld_safe &

# Wait for MariaDB to start up 
while ! mysqladmin ping --silent; do 
    echo 'Waiting for MariaDB to be available...' 
    sleep 2
done

# Run the SQL initialization script to create the database and users
# This will only run if the database is empty (first-time initialization)
if [ ! -d "/var/lib/mysql/${DATABASE_NAME}" ]; then
    echo "Initializing database..."

    # Load secrets from Docker secrets
    USER_NAME=$(cat /run/secrets/db_user)
    USER_PASSWORD=$(cat /run/secrets/db_password)
    BOSS_USER=$(cat /run/secrets/db_boss_user)
    BOSS_PASSWORD=$(cat /run/secrets/db_boss_password)

    # Load the database name from an environment variable
    DATABASE_NAME=${DATABASE_NAME}

    # Ensure the target directory exists
    mkdir -p /tools

    # Generate init.sql in the new directory
    cat <<EOL > /tools/init.sql
CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};
CREATE USER '${USER_NAME}'@'%' IDENTIFIED BY '${USER_PASSWORD}';
GRANT SELECT, INSERT, UPDATE, DELETE ON ${DATABASE_NAME}.* TO '${USER_NAME}'@'%';
CREATE USER '${BOSS_USER}'@'%' IDENTIFIED BY '${BOSS_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${BOSS_USER}'@'%';
FLUSH PRIVILEGES;
EOL

    # Execute the init.sql file
    mysql < /tools/init.sql
    echo "Database initialized."
    rm /tools/init.sql
else
    echo "Database already initialized."
fi

# Stop the background MariaDB server 
mysqladmin shutdown

# Now start the MariaDB server properly
# Start MariaDB in the foreground so Docker doesn't exit
exec mysqld_safe
