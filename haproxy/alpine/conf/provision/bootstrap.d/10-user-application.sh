#!/usr/bin/env bash

generate_random() {
    export RANDOM_PASSWORD=`tr -dc A-Za-z0-9 < /dev/urandom | head -c71` ; \
}

change_passwd() {
    generate_random
    echo "$@:$RANDOM_PASSWORD" | chpasswd
    unset RANDOM_PASSWORD
    passwd -l $@
}

addgroup -g "$APPLICATION_GID" "$APPLICATION_GROUP"

adduser --shell /bin/bash -h "/home/$APPLICATION_USER" -D -G "$APPLICATION_GROUP" $APPLICATION_USER

change_passwd "root"
change_passwd "$APPLICATION_USER"

# Create tmp dir for haproxy
mkdir -p /var/tmp/haproxy/

chown ${APPLICATION_USER}:${APPLICATION_GROUP} /var/lib/haproxy
# rm -rf  /var/lib/haproxy/stats
touch /var/lib/haproxy/stats
chown ${APPLICATION_USER}:${APPLICATION_GROUP} /var/lib/haproxy/stats

# rm -rf /var/run/haproxy.pid
touch /var/run/haproxy.pid
chown -R ${APPLICATION_USER}:${APPLICATION_GROUP} /var/run/haproxy.pid