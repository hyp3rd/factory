FROM docker:dind

COPY container-image-baselayout/usr/local/bin/ /usr/local/bin/
COPY conf/ /opt/container/
COPY container-image-baselayout/etc/profile /etc/profile

ENV ENV="/etc/profile" \
    DOCKER_CONF_HOME=/opt \
    TERM="xterm" \
    LANG="C.UTF-8" \
    LC_ALL="C.UTF-8" \
    APPLICATION_USER=application \
    APPLICATION_GROUP=application \
    APPLICATION_UID=1000 \
    APPLICATION_GID=1000

RUN set -x \
    && apk-upgrade \
    && apk-install python3 \
        gcc \
        python3-dev \
        py3-pip  \
        py3-cryptography \
        build-base \
        autoconf \
        automake \
        linux-headers \
        musl-dev \
        libffi-dev \
        openssl-dev \
        openssh \
        git \
    && chmod +x /usr/local/bin/* \
    && chmod +x /opt/container/bin/* \
    /opt/container/provision/bootstrap.d/10-user-application.sh \
    && container-bootstrap \
    && container-cleanup

# USER application

RUN python3 -m pip install --upgrade pip \
    && python3 -m pip install --upgrade ansible ansible-lint yamllint Jinja2 PyYAML \
    && python3 -m pip install --upgrade molecule[docker]

LABEL org.opencontainers.image.vendor="Hyperd" \
    org.opencontainers.image.url="eu.gcr.io/hyperd-containers/molecule" \
    org.opencontainers.image.title="molecule container image" \
    org.opencontainers.image.description="An Alpine based molecule running with unprivileged user" \
    org.opencontainers.image.version="1.0.5" \
    org.opencontainers.image.documentation="README.md"
