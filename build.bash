#!/bin/bash

set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

export REGISTRY="hyperd"
export BASE_DIR=$(pwd)

build() {
    cd "${BASE_DIR}/$1"

    echo
    echo "*** Run time: $(date) @ $(hostname)"
    echo
    echo "workdir: ${BASE_DIR}/$1"
    echo
    echo "building: $2"
    echo

    docker build --no-cache -t $2 .
}

build base/alpine ${REGISTRY}/alpine:base
build haproxy/alpine ${REGISTRY}/haproxy:alpine

run() {
    docker run -p 80:5000 ${REGISTRY}/haproxy:alpine
}

run