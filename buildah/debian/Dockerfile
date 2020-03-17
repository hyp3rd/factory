#+++++++++++++++++++++++++++++++++++++++++++++++++++
# Dockerfile for eu.gcr.io/hyperd-containers/buildah
#+++++++++++++++++++++++++++++++++++++++++++++++++++

FROM eu.gcr.io/hyperd-containers/debian:bullseye-slim

RUN set -x \
    && echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/Debian_10/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list \
    && wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/Debian_10/Release.key -O Release.key \
    && apt-key add - < Release.key \
    && apt-update \
    && apt-install \
        buildah \
        podman \
    && docker-run-bootstrap \
    && docker-image-cleanup