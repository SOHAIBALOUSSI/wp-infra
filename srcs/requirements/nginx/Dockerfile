FROM alpine:3.21.3

RUN apk update && apk add --no-cache bash nginx openssl wget ca-certificates

RUN wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.4/mkcert-v1.4.4-linux-amd64 \
        && chmod +x mkcert-v1.4.4-linux-amd64 \
        && mv mkcert-v1.4.4-linux-amd64 /usr/local/bin/mkcert

RUN mkdir -p /run/nginx /etc/nginx/ssl /root/.local/share/mkcert

COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf

RUN mkcert -install \
    && mkcert -cert-file /etc/nginx/ssl/nginx.crt -key-file /etc/nginx/ssl/nginx.key \
    sait-alo.42.fr localhost 127.0.0.1 ::1

RUN mkdir -p /var/www/html/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]