FROM alpine:3.21.3
RUN apk update && apk add --no-cache redis
EXPOSE 6379
CMD ["redis-server", "--daemonize", "no", "--protected-mode", "no"]