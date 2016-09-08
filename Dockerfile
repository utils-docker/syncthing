FROM alpine:3.4
MAINTAINER Fábio Luciano <fabioluciano@php.net>
LABEL Description="Cria um servidor do Syncthing"

ENV SYNCTHING_USER syncthing
ENV SYNCTHING_HOME /mnt/syncthing

COPY files/* /etc/

RUN apk update \
  && apk --update --no-cache add supervisor \
  && rm -rf /var/cache/apk/*


VOLUME $SYNCTHING_HOME
WORKDIR $SYNCTHING_HOME

EXPOSE 8384/tcp 22000/tcp 21025/udp 21027/udp

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
