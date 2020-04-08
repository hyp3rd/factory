FROM quay.io/ansible/molecule@sha256:72729fb8edde1eefbca06e91b6c651e0aa5a6c8baeaeaa30dee38b64de1cc759

COPY container-image-baselayout/usr/local/bin/ /usr/local/bin/
COPY conf/ /opt/container/

ENV DOCKER_CONF_HOME=/opt \
    TERM="xterm" \
    LANG="C.UTF-8" \
    LC_ALL="C.UTF-8" \
    APPLICATION_USER=application \
    APPLICATION_GROUP=application \
    APPLICATION_UID=1000 \
    APPLICATION_GID=1000

RUN set -x \
    && apk-upgrade \
    && chmod +x /usr/local/bin/* \
    && chmod +x /opt/container/bin/* \
    /opt/container/provision/bootstrap.d/10-user-application.sh \
    && container-bootstrap \
    && container-cleanup

USER application

RUN python -m pip install --user --upgrade pip \
    && python -m pip install --user --upgrade ansible ansible-lint yamllint Jinja2 PyYAML \
    && python -m pip install --user --upgrade molecule[docker]

LABEL org.opencontainers.image.vendor="Hyperd" \
    org.opencontainers.image.url="eu.gcr.io/hyperd-containers/molecule" \
    org.opencontainers.image.title="molecule container image" \
    org.opencontainers.image.description="An Alpine based molecule running with unprivileged user" \
    org.opencontainers.image.version="1.0.5" \
    org.opencontainers.image.documentation="README.md"
