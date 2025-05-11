#!/bin/sh
# Ensure the socket directory exists with proper permissions
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

if [ -z "$(ls -A /var/lib/mysql)" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    echo "Creating user: ${DB_USER}"
    mariadbd --user=mysql --bootstrap <<-EOSQL
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOSQL
else
    echo "MariaDB already initialized. Skipping bootstrap."
fi

exec mariadbd --user=mysql