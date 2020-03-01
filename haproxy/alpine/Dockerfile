#+++++++++++++++++++++++++++++++++++++++
# Dockerfile for hyperd/haproxy:alpine
#+++++++++++++++++++++++++++++++++++++++

FROM hyperd/alpine:base

ENV APPLICATION_USER=application \
    APPLICATION_GROUP=application \
    APPLICATION_UID=1000 \
    APPLICATION_GID=1000 \
    LB_STRATEGY=roundrobin \
    LB_FRONTEND_PORT=5000

COPY conf/ /opt/docker/

RUN set -x \
    && apk-install haproxy --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main \
    && docker-run-bootstrap \
    && docker-image-cleanup \
    && chown -R ${APPLICATION_USER}:${APPLICATION_GROUP} /opt/docker/ \
    && chown -R ${APPLICATION_USER}:${APPLICATION_GROUP} /var/lib/syslog-ng \
    && touch /run/syslog-ng.persist- \
    && touch /run/syslog-ng.pid \
    && touch /run/syslog-ng.ctl \
    # && chown -R ${APPLICATION_USER}:${APPLICATION_GROUP} /run/syslog-ng.persist- \
    # && chown -R ${APPLICATION_USER}:${APPLICATION_GROUP} /run/syslog-ng.pid \
    # && chown -R ${APPLICATION_USER}:${APPLICATION_GROUP} /run/syslog-ng.ctl
    && chown -R ${APPLICATION_USER}:${APPLICATION_GROUP} /run/*

USER ${APPLICATION_USER}

# ENTRYPOINT ["/opt/docker/bin/service.d/haproxy.sh"]

EXPOSE 80 443