#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then
    # Initialize MariaDB data directory
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    /usr/bin/mysqld --user=mysql --bootstrap << EOF
    USE mysql;
    FLUSH PRIVILEGES;
    CREATE DATABASE IF NOT EXISTS wordpress;
    CREATE USER IF NOT EXISTS 'sait-alo'@'%' IDENTIFIED BY 's1s2s3@sss';
    GRANT ALL PRIVILEGES ON wordpress.* TO 'sait-alo'@'%';
    FLUSH PRIVILEGES;
EOF
fi

exec /usr/bin/mysqld --user=mysql