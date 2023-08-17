FROM alpine:3.18

RUN apk add --no-cache curl expect pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/

ENV FTP_DIR /srv/ftp
ENV USERNAME username
ENV PASSWORD password

RUN adduser -D -h ${FTP_DIR} -s /etc ftpv

EXPOSE 21 30000-30009

COPY rootfs /

ENTRYPOINT [ "/docker-entrypoint.sh" ]
