FROM alpine:3.4
MAINTAINER Fábio Luciano <fabioluciano@php.net>
LABEL Description="Cria um servidor do Syncthing"

ENV SYNCTHING_USER="syncthing" \
    SYNCTHING_HOME="/mnt/syncthing" \
    SYNCTHING_VERSION="v0.14.6" \
    URL=" https://github.com/syncthing/syncthing/releases/download/"

COPY files/* /etc/

WORKDIR /tmp

RUN apk update \
  && apk --update --no-cache add supervisor openssl \
  && rm -rf /var/cache/apk/*

RUN wget $URL$SYNCTHING_VERSION/syncthing-linux-amd64-$SYNCTHING_VERSION.tar.gz && ls -lh


VOLUME $SYNCTHING_HOME
WORKDIR $SYNCTHING_HOME

EXPOSE 8384/tcp 22000/tcp 21025/udp 21027/udp

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
