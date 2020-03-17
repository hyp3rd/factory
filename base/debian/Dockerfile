#++++++++++++++++++++++++++++++++++++++++++++++++++
# Dockerfile for eu.gcr.io/hyperd-containers/debian:bullseye-slim
#++++++++++++++++++++++++++++++++++++++++++++++++++

FROM debian:bullseye-slim

ENV DOCKER_CONF_HOME=/opt/docker/ \
    LOG_STDOUT="" \
    LOG_STDERR="" \
    TERM="xterm" \
    LANG="C.UTF-8" \
    LC_ALL="C.UTF-8"

COPY docker-image-baselayout/root/usr/local/bin/ /usr/local/bin/
COPY conf/ /opt/docker/

RUN set -x \
    # Install packages
    && chmod +x /opt/docker/bin/* \
    && apt-upgrade \
    && apt-install \
        wget \
        gnupg2 \
        apt-transport-https \
        apt-utils \
        ca-certificates \
    && docker-run-bootstrap \
    && docker-image-cleanup

ENTRYPOINT ["/entrypoint"]

LABEL org.opencontainers.image.vendor="Hyperd" \
    org.opencontainers.image.url="eu.gcr.io/hyperd-containers/debian:bullseye-slim" \
    org.opencontainers.image.title="debian:bullseye-slim Containers Image Factory" \
    org.opencontainers.image.description="A base debian:bullseye-slim Containers Image Factory" \
    org.opencontainers.image.version="v0.5" \
    org.opencontainers.image.documentation="README.md"
