FROM quay.io/ansible/molecule

ENV DOCKER_CONF_HOME=/opt \
    TERM="xterm" \
    LANG="C.UTF-8" \
    LC_ALL="C.UTF-8"

RUN apk update \
    && apk upgrade \
    && pip3 install --upgrade pip \
    && pip3 install --upgrade ansible ansible-lint yamllint Jinja2 PyYAML \
    && pip3 install --upgrade molecule[docker]

LABEL org.opencontainers.image.vendor="ESC Squad" \
    org.opencontainers.image.url="ansibletower.ing.net/moleculer" \
    org.opencontainers.image.title="ansible molecule enabled container image" \
    org.opencontainers.image.description="A container loaded with the necessary toolset to run molecule testing" \
    org.opencontainers.image.version="v1.0.1" \
    org.opencontainers.image.documentation="README.md"
