FROM alpine:3.21.3

RUN apk update && apk add --no-cache \
    curl php php-session php-mysqli php-pdo php-pdo_mysql

WORKDIR /usr/share/adminer/

RUN curl -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -o adminer.php

CMD [ "php", "-S", "0.0.0.0:8080", "adminer.php" ]