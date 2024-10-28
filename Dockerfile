FROM alpine:3.20

RUN apk add --no-cache curl expect pure-ftpd

ENV FTP_DIR /srv/ftp
ENV USERNAME username
ENV PASSWORD password

RUN adduser -D -h ${FTP_DIR} -s /etc ftpv

EXPOSE 21 30000-30009

COPY rootfs /

ENTRYPOINT [ "/entrypoint.sh" ]
