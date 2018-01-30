FROM ubuntu

LABEL maintainer="Leonid Suprun <leonid@suprun.pw>"
VOLUME [ "/var/cache/apt/" ]

RUN apt-get update \
 && apt-get install -y --no-install-recommends dpkg-dev \
 && apt-get clean \
 && rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN rm /etc/apt/apt.conf.d/docker-clean

COPY dockerfile-entrypoint.sh /
ENTRYPOINT ["/dockerfile-entrypoint.sh"]
