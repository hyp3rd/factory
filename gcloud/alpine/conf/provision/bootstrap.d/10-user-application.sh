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
