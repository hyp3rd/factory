# Python Container Images

**BASE IMAGE**: [Base/Centos](../../base/centos/README.md)

**ENTRYPOINT**: ["python3"]

## Synopsis

A brief desciption of the **python** images deployed in this registry.

### eu.gcr.io/hyperd-containers/venv-builder:latest

The **venv-builder** image is engineered to build virtual environments able to ship both **python 2.x** and **3.x** binaries.

The container is built from **CentOS** including a the necessary set of packages to allow building the virtual environments both leveraging python 2 and python 3.

```bash
# ...
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
    && pip3 install venvctl==1.3.7 psutil==5.7.0 \
    && pip2 install --upgrade pip==20.0.2 \
    && pip2 install virtualenv==20.0.15 \
    && docker-run-bootstrap \
    && docker-image-cleanup
# ...
```

Example command to build virtual environments in batch, shipping Python 3.6.8 shipped with RHEL based systems:

```bash
docker run -it --rm -v $(pwd)/conf.json:/opt/conf.json \
  -v $(pwd)/venvs:/opt/venvs:rw \
  eu.gcr.io/hyperd-containers/venv-builder:latest venvctl generate \
  --config /opt/conf.json \
  --out /opt/venvs \
```

Example command to build virtual environments in batch, shipping Python 2.7.16:

```bash
docker run -it --rm -v $(pwd)/conf.json:/opt/conf.json \
  -v $(pwd)/venvs:/opt/venvs:rw \
  eu.gcr.io/hyperd-containers/venv-builder:latest venvctl generate \
  --config /opt/conf.json \
  --out /opt/venvs \
  --python /usr/bin/python2
```
