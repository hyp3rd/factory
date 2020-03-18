#+++++++++++++++++++++++++++++++++++++++++++++++++++
# Dockerfile for eu.gcr.io/hyperd-containers/python3
#+++++++++++++++++++++++++++++++++++++++++++++++++++

FROM eu.gcr.io/hyperd-containers/centos:base

COPY conf/ /opt/docker/

RUN set -x \
    && yum-install \
        make \
        gcc \
        zlib-devel \
        bzip2-devel \
        openssl-devel \
        ncurses-devel \
        sqlite-devel \
        readline-devel \
        tk-devel \
        gdbm-devel \
        xz-devel \
        libffi-devel \
    && curl https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tgz -o Python-3.8.2.tgz \
    && tar xzf Python-3.8.2.tgz \
    && cd Python-3.8.2 \
    && ./configure --enable-optimizations \
    && make altinstall -j6 \
    && cd - \
    && rm -rf Python-3.8.2.tgz Python-3.8.2 \
    && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3.8 get-pip.py \
    && rm -rf get-pip.py \
    && pip3 install --upgrade pip \
    && pip3 install venvctl \
    && docker-run-bootstrap \
    && docker-image-cleanup


CMD ["python3"]

LABEL org.opencontainers.image.vendor="Hyperd" \
    org.opencontainers.image.url="eu.gcr.io/hyperd-containers/python3:centos" \
    org.opencontainers.image.title="python3 on CentoOS by Containers Image Factory" \
    org.opencontainers.image.description="A simple python3 runninng with unprivileged user." \
    org.opencontainers.image.version="v0.5" \
    org.opencontainers.image.documentation="README.md"
