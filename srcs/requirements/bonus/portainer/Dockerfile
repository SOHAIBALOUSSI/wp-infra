FROM alpine:3.21.3

RUN apk update && apk add --no-cache curl \
    && curl -L https://github.com/portainer/portainer/releases/download/2.11.1/portainer-2.11.1-linux-amd64.tar.gz -o portainer.tar.gz \
    && tar -xzf portainer.tar.gz && rm portainer.tar.gz

EXPOSE 9000

CMD ["/portainer/portainer"]