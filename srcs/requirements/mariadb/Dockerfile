FROM alpine:3.21.3
RUN apk update && apk add --no-cache mariadb mariadb-client \
    && mkdir -p /run/mysqld /var/lib/mysql \
    && chown -R mysql:mysql /run/mysqld /var/lib/mysql
COPY ./conf/mariadb.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY ./tools/dbconfig.sh /
RUN chmod +x /dbconfig.sh
ENTRYPOINT [ "/dbconfig.sh" ]