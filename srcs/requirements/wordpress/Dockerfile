FROM alpine:3.21.3


RUN apk update && apk add --no-cache \
        php83 php83-fpm php83-mysqli php83-json php83-curl \
        php83-dom php83-mbstring php83-xml php83-zip php83-phar php83-tokenizer php83-ftp \
        wget curl mariadb-client php83-pdo php83-pdo_mysql  \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp \
    && sed -i 's/listen = 127.0.0.1:9000/listen = 9000/' /etc/php83/php-fpm.d/www.conf

WORKDIR /var/www/html

COPY tools/wpconfig.sh /

RUN chmod +x /wpconfig.sh
RUN sed -i 's/^upload_max_filesize = .*/upload_max_filesize = 100M/' /etc/php83/php.ini && \
    sed -i 's/^post_max_size = .*/post_max_size = 512M/' /etc/php83/php.ini && \
    sed -i 's/^memory_limit = .*/memory_limit = 512M/' /etc/php83/php.ini && \
    sed -i 's/^max_execution_time = .*/max_execution_time = 300/' /etc/php83/php.ini


ENTRYPOINT [ "/wpconfig.sh" ]
