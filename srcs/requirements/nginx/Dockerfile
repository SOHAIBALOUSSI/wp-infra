FROM alpine:3.21.3
RUN apk update && apk add --no-cache nginx
RUN mkdir -p /var/www/html/
COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]