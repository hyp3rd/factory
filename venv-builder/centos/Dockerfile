#++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Dockerfile for eu.gcr.io/hyperd-containers/venv-builder
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++

FROM eu.gcr.io/hyperd-containers/centos:base

COPY conf/ /opt/docker/
COPY tests/ /opt/docker/tests

RUN set -x \
    && yum-upgrade \
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
        python2-devel \
        python3-devel \
        openldap-devel \
    && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3 get-pip.py \
    && rm -rf get-pip.py \
    && python3 -m pip install venvctl==1.3.19 psutil==5.7.0 \
    && python2 -m pip install --upgrade pip==20.0.2 \
    && python2 -m pip install virtualenv==20.0.20 \
    && docker-run-bootstrap \
    && docker-image-cleanup

LABEL org.opencontainers.image.vendor="Hyperd" \
    org.opencontainers.image.url="eu.gcr.io/hyperd-containers/venv-builder" \
    org.opencontainers.image.title="virtual envs builder based on CentoOS Container Image" \
    org.opencontainers.image.description="A virtual envs builder leveraging both Python 3 and Python 2" \
    org.opencontainers.image.version="v1.0.0" \
    org.opencontainers.image.documentation="README.md"
