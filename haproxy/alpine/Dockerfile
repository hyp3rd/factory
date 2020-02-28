#+++++++++++++++++++++++++++++++++++++++
# Dockerfile for hyperd/haproxy:alpine
#+++++++++++++++++++++++++++++++++++++++

FROM hyperd/base:alpine

ENV HAPROXY_VERSION 2.1.3
ENV HAPROXY_SHA256 bb678e550374d0d9d9312885fb9d270b501dae9e3b336f0a4379c667dae00b59

COPY src/haproxy.tar.gz /

RUN echo "$HAPROXY_SHA256 *haproxy.tar.gz" | sha256sum -c

RUN set -x \
    \
    && apk add --no-cache --virtual .build-deps \
    ca-certificates \
    gcc \
    libc-dev \
    linux-headers \
    lua5.3-dev \
    make \
    openssl \
    openssl-dev \
    pcre2-dev \
    readline-dev \
    tar \
    zlib-dev

RUN set -x \
    \
    && mkdir -p /usr/src/haproxy \
    && tar -xzf haproxy.tar.gz -C /usr/src/haproxy --strip-components=1 \
    && rm haproxy.tar.gz \
    \
    && makeOpts=' \
    TARGET=linux-glibc \
    USE_GETADDRINFO=1 \
    USE_LUA=1 LUA_INC=/usr/include/lua5.3 LUA_LIB=/usr/lib/lua5.3 \
    USE_OPENSSL=1 \
    USE_PCRE2=1 USE_PCRE2_JIT=1 \
    USE_ZLIB=1 \
    \
    EXTRA_OBJS=" \
    contrib/prometheus-exporter/service-prometheus.o \
    " \
    ' \
    && nproc="$(getconf _NPROCESSORS_ONLN)" \
    && eval "make -C /usr/src/haproxy -j '$nproc' all $makeOpts" \
    && eval "make -C /usr/src/haproxy install-bin $makeOpts" \
    \
    && mkdir -p /usr/local/etc/haproxy \
    && cp -R /usr/src/haproxy/examples/errorfiles /usr/local/etc/haproxy/errors \
    && rm -rf /usr/src/haproxy \
    && mkdir -p /var/lib/haproxy \
    && touch /var/lib/haproxy/stats \
    \
    && runDeps="$( \
    scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
    | tr ',' '\n' \
    | sort -u \
    | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )" \
    && apk add --no-network --virtual .haproxy-rundeps $runDeps \
    && apk del --no-network .build-deps

ENV APPLICATION_USER=application \
    APPLICATION_GROUP=application \
    APPLICATION_UID=1000 \
    APPLICATION_GID=1000 \
    LB_STRATEGY=roundrobin \
    LB_FRONTEND_PORT=5000

COPY conf/ /opt/docker/

RUN set -x \
    && apk-install shadow \
    && docker-run-bootstrap \
    && docker-image-cleanup

EXPOSE 80 443