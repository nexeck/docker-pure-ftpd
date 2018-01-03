FROM alpine:3.7

RUN apk add --no-cache curl expect pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/

ENV SYSLOG_STDOUT_VERSION 1.1.1
RUN curl -ksL "https://github.com/timonier/syslog-stdout/releases/download/v${SYSLOG_STDOUT_VERSION}/syslog-stdout.tar.gz" | tar fxz - -C /usr/sbin

ENV FTP_DIR /srv/ftp
ENV USERNAME username
ENV PASSWORD password

RUN adduser -D -h ${FTP_DIR} -s /etc ftpv

EXPOSE 21 30000-30009

COPY docker-entrypoint.sh /
ENTRYPOINT [ "/docker-entrypoint.sh" ]
