#!/bin/sh
set -e

if [ ! -f wp-config.php ]; then
    curl -O https://wordpress.org/latest.tar.gz
    tar -xzvf latest.tar.gz
    cp -R wordpress/* .
    rm -rf wordpress latest.tar.gz
    wp config create --dbhost="${DB_HOST}" --dbname="${DB_NAME}" \
                        --dbuser="${DB_USER}" --dbpass="${DB_PASSWORD}"
    
    # Configure WordPress for SSL
    wp config set FORCE_SSL_ADMIN true --raw
    wp config set WP_HOME "${WP_URL}"
    wp config set WP_SITEURL "${WP_URL}"

    
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
        
        # wp user create "${WP_AUTHOR_USER}" "${WP_AUTHOR_EMAIL}" \
        # --role=author --user_pass="${WP_AUTHOR_PASSWORD}"
    fi
    # Redis configuration disabled since Redis service is not running
    # wp config set WP_REDIS_HOST redis 
    # wp config set WP_REDIS_PORT 6379 
    # wp config set WP_CACHE 'true'
    # wp config set WP_REDIS_DATABASE 0 
    # sleep 1
    # wp plugin install redis-cache --activate 
    # wp redis enable 
    
    # Set file system method to direct (no FTP needed)
    wp config set FS_METHOD direct
    
    # Configure FTP as fallback (use Docker service name for internal communication)
    wp config set FTP_HOST ftp
    wp config set FTP_PORT 21 --raw
    wp config set FTP_USER ftp
    wp config set FTP_PASS 1234
    wp config set FTP_BASE /var/www/html/
    wp config set FTP_CONTENT_DIR /var/www/html/wp-content/
    wp config set FTP_PLUGIN_DIR /var/www/html/wp-content/plugins/

fi

# Fix ownership and permissions recursively
chown -R nobody:nobody /var/www/html
chmod -R 755 /var/www/html

# Ensure wp-content, uploads, upgrade, plugins, themes are writable
find /var/www/html/wp-content -type d -exec chmod 775 {} \;
find /var/www/html/wp-content -type f -exec chmod 664 {} \;

# Create necessary subfolders with correct perms
mkdir -p wp-content/uploads wp-content/upgrade
chmod -R 775 wp-content/uploads wp-content/upgrade

# PHP-FPM will run as nobody, so make sure it has access
chown -R nobody:nobody wp-content/uploads wp-content/upgrade wp-content/plugins wp-content/themes

# Optional: clear any restrictive ACLs
setfacl -bR wp-content/ 2>/dev/null || true

exec php-fpm83 -F
