#+++++++++++++++++++++++++++++++++++++++++++++++++++
# Dockerfile for eu.gcr.io/hyperd-containers/python3
#+++++++++++++++++++++++++++++++++++++++++++++++++++

FROM eu.gcr.io/hyperd-containers/centos:base

ENV APPLICATION_USER=application \
    APPLICATION_GROUP=application \
    APPLICATION_UID=1000 \
    APPLICATION_GID=1000

COPY conf/ /opt/docker/

RUN set -x \
    && yum-install python3 \
    && pip3 install --upgrade pip \
    && docker-run-bootstrap \
    && docker-image-cleanup \
    && chown -R ${APPLICATION_USER}:${APPLICATION_GROUP} /opt/docker/


# USER ${APPLICATION_USER}

CMD ["python3"]

LABEL org.opencontainers.image.vendor="Hyperd" \
    org.opencontainers.image.url="eu.gcr.io/hyperd-containers/python3:centos" \
    org.opencontainers.image.title="python3 on CentoOS by Containers Image Factory" \
    org.opencontainers.image.description="A simple python3 runninng with unprivileged user." \
    org.opencontainers.image.version="v0.5" \
    org.opencontainers.image.documentation="README.md"
