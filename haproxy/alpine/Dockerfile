#+++++++++++++++++++++++++++++++++++++++
# Dockerfile for hyperd/haproxy:alpine
#+++++++++++++++++++++++++++++++++++++++

FROM hyperd/base:alpine

ENV APPLICATION_USER=application \
    APPLICATION_GROUP=application \
    APPLICATION_UID=1000 \
    APPLICATION_GID=1000 \
    LB_STRATEGY=roundrobin \
    LB_FRONTEND_PORT=5000

COPY conf/ /opt/docker/

RUN set -x \
    # && apk-install shadow \
    && apk-install haproxy --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main \
    && docker-run-bootstrap \
    && docker-image-cleanup \
    && chown -R ${APPLICATION_USER}:${APPLICATION_GROUP} /opt/docker/ \
    && chmod +x /opt/docker/provision/entrypoint.d/20-haproxy.sh \
    && chmod +x /opt/docker/bin/service.d/haproxy.sh

RUN /opt/docker/provision/entrypoint.d/20-haproxy.sh

USER ${APPLICATION_USER}

CMD ["/opt/docker/bin/service.d/haproxy.sh"]

EXPOSE 80 443