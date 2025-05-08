FROM alpine:3.21.3

RUN apk update && apk add --no-cache \
        php83 php83-fpm php83-mysqli php83-json php83-curl \
        php83-dom php83-mbstring php83-xml php83-zip php83-phar \
        wget curl mariadb-client \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp \
    && sed -i 's/listen = 127.0.0.1:9000/listen = 9000/' /etc/php83/php-fpm.d/www.conf

WORKDIR /var/www/html

COPY tools/wpconfig.sh /

RUN chmod +x /wpconfig.sh

ENTRYPOINT [ "/wpconfig.sh" ]
