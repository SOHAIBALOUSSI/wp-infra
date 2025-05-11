#!/bin/sh
set -e

if [ ! -f wp-config.php ]; then
    curl -O https://wordpress.org/latest.tar.gz
    tar -xzvf latest.tar.gz
    cp -R wordpress/* .
    rm -rf wordpress latest.tar.gz
    wp config create --dbhost="${DB_HOST}" --dbname="${DB_NAME}" \
                        --dbuser="${DB_USER}" --dbpass="${DB_PASSWORD}"

    
    until wp db check ; do
        echo "Waiting for database..."
        sleep 1
    done

    if ! wp core is-installed ; then
        wp core install \
            --url=${WP_URL} \
            --title="${WP_TITLE}" \
            --admin_user="${WP_ADMIN_USER}" \
            --admin_password="${WP_ADMIN_PASSWORD}" \
            --admin_email="${WP_ADMIN_EMAIL}" \
            --skip-email
        
        wp user create "${WP_AUTHOR_USER}" "${WP_AUTHOR_EMAIL}" \
        --role=author --user_pass="${WP_AUTHOR_PASSWORD}"
    fi
    wp config set WP_REDIS_HOST redis 
    wp config set WP_REDIS_PORT 6379 
    wp config set WP_CACHE 'true'
    wp config set WP_REDIS_DATABASE 0 
    sleep 1
    wp plugin install redis-cache --activate 
    wp redis enable 

fi

exec php-fpm83 -F
