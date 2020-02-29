#+++++++++++++++++++++++++++++++++++++++
# Dockerfile for hyperd/base:alpine
#+++++++++++++++++++++++++++++++++++++++

FROM alpine:3.9.5

ENV TERM="xterm" \
    LANG="C.UTF-8" \
    LC_ALL="C.UTF-8" \
    DOCKER_CONF_HOME=/opt/docker/ \
    LOG_STDOUT="" \
    LOG_STDERR=""

COPY docker-image-baselayout/root/usr/local/bin/ /usr/local/bin/
COPY conf/ /opt/docker/

RUN set -x \
    # Install services
    && chmod +x /usr/local/bin/* \
    && chmod +x /opt/docker/bin/* \
    && apk-install \
    syslog-ng \
    supervisor \
    bash \
    && touch /run/supervisord.sock \
    && docker-run-bootstrap \
    && docker-image-cleanup

ENTRYPOINT ["/entrypoint"]
CMD ["supervisord"]

LABEL org.opencontainers.image.vendor="Hyperd" \
    org.opencontainers.image.url="https://hyperd.sh" \
    org.opencontainers.image.title="Base Alpine Docker Image" \
    org.opencontainers.image.description="A doceker image to build alpine based containers, with supervisored processes." \
    org.opencontainers.image.version="v0.5" \
    org.opencontainers.image.documentation="README.md"
