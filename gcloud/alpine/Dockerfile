FROM docker:dind

COPY container-image-baselayout/usr/local/bin/ /usr/local/bin/
COPY conf/ /opt/container/
COPY container-image-baselayout/etc/profile /etc/profile

ENV ENV="/etc/profile" \
    TERM="xterm" \
    LANG="C.UTF-8" \
    LC_ALL="C.UTF-8" \
    APPLICATION_USER=application \
    APPLICATION_GROUP=application \
    APPLICATION_UID=1000 \
    APPLICATION_GID=1000 \
    CLOUDSDK_PYTHON=python3

RUN apk-upgrade \
    && apk-install python3 \
    && wget -O gcloud-sdk.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-288.0.0-linux-x86_64.tar.gz \
    && tar xzfv gcloud-sdk.tar.gz \
    && rm -rf gcloud-sdk.tar.gz \
    && ./google-cloud-sdk/install.sh --quiet --path-update true \
    && ./google-cloud-sdk/bin/gcloud components install kubectl --quiet \
    && ./google-cloud-sdk/bin/gcloud config set disable_usage_reporting false \
    && chmod +x /usr/local/bin/* \
    && chmod +x /opt/container/bin/* \
    /opt/container/provision/bootstrap.d/10-user-application.sh \
    && container-bootstrap \
    && container-cleanup

LABEL org.opencontainers.image.vendor="F." \
    org.opencontainers.image.url="eu.gcr.io/hyperd-containers/gcloud" \
    org.opencontainers.image.title="gcloud Container Image" \
    org.opencontainers.image.description="An Alpine based image shipping gcloud and kubectl" \
    org.opencontainers.image.version="0.5.0" \
    org.opencontainers.image.documentation="README.md"
