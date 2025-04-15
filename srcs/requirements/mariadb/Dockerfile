FROM alpine:3.21.3

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN mkdir -p /run/mysqld /var/lib/mysqld

RUN chown -R mysql:mysql /run/mysqld /var/lib/mysqld

COPY ./conf/mariadb.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY ./tools/dbconfig.sh /docker-entrypoint-initdb.d/

RUN chmod +x /docker-entrypoint-initdb.d/dbconfig.sh

ENTRYPOINT [ "/docker-entrypoint-initdb.d/dbconfig.sh" ]