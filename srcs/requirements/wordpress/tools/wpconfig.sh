#!/bin/sh
set -e

if [ ! -f wp-config.php ]; then
    curl -O https://wordpress.org/latest.tar.gz
    tar -xzvf latest.tar.gz
    cp -R wordpress/* .
    rm -rf wordpress latest.tar.gz
    rm -f wp-config-sample.php wp-config.php
    
    wp config create --dbhost="${DB_HOST}" \
                        --dbname="${DB_NAME}" \
                        --dbuser="${DB_USER}" \
                        --dbpass="${DB_PASSWORD}" \
                        --allow-root
    
    until wp db check --allow-root; do
        echo "Waiting for database..."
        sleep 1
    done

    if ! wp core is-installed --allow-root; then
        wp core install \
            --url=${WP_URL} \
            --title="${WP_TITLE}" \
            --admin_user="${WP_ADMIN_USER}" \
            --admin_password="${WP_ADMIN_PASSWORD}" \
            --admin_email="${WP_ADMIN_EMAIL}" \
            --skip-email \
            --allow-root
    fi
    wp config set WP_REDIS_HOST redis --allow-root
    wp config set WP_REDIS_PORT 6379 --allow-root
    wp config set WP_CACHE 'true' --allow-root
    wp config set WP_REDIS_DATABASE 0 --allow-root
    sleep 2
    wp plugin install redis-cache --activate --allow-root
    wp redis enable --allow-root

fi

chown -R nobody:nobody /var/www/html

exec "$@"
