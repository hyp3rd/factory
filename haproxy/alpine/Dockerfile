#+++++++++++++++++++++++++++++++++++++++++++++++++++
# Dockerfile for eu.gcr.io/hyperd-containers/haproxy
#+++++++++++++++++++++++++++++++++++++++++++++++++++

FROM eu.gcr.io/hyperd-containers/alpine:base

ENV APPLICATION_USER=application \
    APPLICATION_GROUP=application \
    APPLICATION_UID=1000 \
    APPLICATION_GID=1000 \
    LB_MODE=http \
    LB_STRATEGY=roundrobin \
    LB_FRONTEND_PORT=5000

COPY conf/ /opt/docker/

RUN set -x \
    && apk-install haproxy --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main \
    && haproxy -v \
    && docker-run-bootstrap \
    && docker-image-cleanup \
    && chown -R ${APPLICATION_USER}:${APPLICATION_GROUP} /opt/docker/ \
    && touch /var/log/haproxy.log \
    # && touch /var/log/messages \
    # && touch /var/log/messages-kv.log \
    && chown -R ${APPLICATION_USER}:${APPLICATION_GROUP} /var/log/*
# && touch /run/syslog-ng.persist- \
# && rm -rf /run/syslog-ng.pid \
# && touch /run/syslog-ng.pid \
# && rm -rf /run/syslog-ng.ctl \
# && touch /run/syslog-ng.ctl \
# && chown -R ${APPLICATION_USER}:${APPLICATION_GROUP} /var/lib/syslog-ng \
# && chown -R ${APPLICATION_USER}:${APPLICATION_GROUP} /run/syslog-ng.persist- \
# && chown -R ${APPLICATION_USER}:${APPLICATION_GROUP} /run/syslog-ng.pid && chmod 640 /run/syslog-ng.pid \
# && chown -R ${APPLICATION_USER}:${APPLICATION_GROUP} /run/syslog-ng.ctl

USER ${APPLICATION_USER}

EXPOSE 80 443

LABEL org.opencontainers.image.vendor="Hyperd" \
    org.opencontainers.image.url="eu.gcr.io/hyperd-containers/haproxy" \
    org.opencontainers.image.title="HAProxy Factory Docker Image" \
    org.opencontainers.image.description="A supervisored HAPRoxy running with unprivileged user." \
    org.opencontainers.image.version="v0.5" \
    org.opencontainers.image.documentation="README.md"
