#+++++++++++++++++++++++++++++++++++++++++++++++++++*
# Dockerfile for eu.gcr.io/hyperd-containers/python:3
#+++++++++++++++++++++++++++++++++++++++++++++++++++*

FROM eu.gcr.io/hyperd-containers/alpine:base

ENV APPLICATION_USER=application \
    APPLICATION_GROUP=application \
    APPLICATION_UID=1000 \
    APPLICATION_GID=1000

COPY conf/ /opt/docker/

RUN set -x \
    && apk-install python3 --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main \
    && pip3 install --upgrade pip==20.0.2 \
    && docker-run-bootstrap \
    && docker-image-cleanup \
    && chown -R ${APPLICATION_USER}:${APPLICATION_GROUP} /opt/docker/


# USER ${APPLICATION_USER}

CMD ["python3"]

LABEL org.opencontainers.image.vendor="Hyperd" \
    org.opencontainers.image.url="eu.gcr.io/hyperd-containers/python:3" \
    org.opencontainers.image.title="Python 3 Container Image" \
    org.opencontainers.image.description="A simple Python 3 alpine based container" \
    org.opencontainers.image.version="v0.5" \
    org.opencontainers.image.documentation="README.md"
