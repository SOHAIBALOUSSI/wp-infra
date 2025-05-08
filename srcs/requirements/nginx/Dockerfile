FROM alpine:3.21.3

RUN apk update && apk add --no-cache nginx openssl ca-certificates

RUN mkdir -p /run/nginx /etc/nginx/ssl

COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=MA/ST=Benguerir/L=Benguerir/O=1337/CN=sait-alo.42.fr"

RUN mkdir -p /var/www/html/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]