#!/bin/sh

adduser -D ${FTP_USER}

echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd 

chown -R ${FTP_USER}:${FTP_USER} /var/www/html

exec vsftpd /etc/vsftpd/vsftpd.conf