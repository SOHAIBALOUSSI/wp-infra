FROM alpine:3.21.3
RUN apk update && apk add --no-cache nginx openssl
RUN mkdir -p /var/www/html/
COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf

RUN mkdir -p /etc/nginx/certs/
RUN echo "[ req ]" > /tmp/openssl.conf && \
    echo "distinguished_name = req_distinguished_name" >> /tmp/openssl.conf && \
    echo "req_extensions = v3_req" >> /tmp/openssl.conf && \
    echo "[ req_distinguished_name ]" >> /tmp/openssl.conf && \
    echo "[ v3_req ]" >> /tmp/openssl.conf && \
    echo "subjectAltName = DNS:localhost,IP:127.0.0.1" >> /tmp/openssl.conf
RUN openssl req -x509 -newkey rsa:4096 -keyout /etc/nginx/certs/sait-alo.42.fr+4-key.pem \
    -out /etc/nginx/certs/sait-alo.42.fr+4.pem -sha256 -days 365 \
    -nodes -subj "/C=US/ST=CA/L=San Francisco/O=Docker/OU=Docker/CN=localhost" \
    -config /tmp/openssl.conf -extensions v3_req
EXPOSE 443 80
CMD ["nginx", "-g", "daemon off;"]

#openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 3650
