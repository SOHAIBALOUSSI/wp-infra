FROM alpine:3.21.3
RUN apk update && apk add --no-cache vsftpd lftp
COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY tools/vsftpd-setup.sh /
RUN chmod +x /vsftpd-setup.sh
EXPOSE 21
ENTRYPOINT ["/vsftpd-setup.sh"]