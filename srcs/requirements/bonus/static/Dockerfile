FROM alpine:3.21.3

RUN apk update && apk add --no-cache php
RUN mkdir -p /www/html/
COPY index.html /www/html/
WORKDIR /www/html/
CMD ["php", "-S", "0.0.0.0:8080"]