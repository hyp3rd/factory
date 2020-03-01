#!/bin/bash

set -Eeuo pipefail

traperr() {
  echo "ERROR: ${BASH_SOURCE[1]} at about line ${BASH_LINENO[0]} ${ERR}"
}

set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value
set -o errtrace

trap traperr ERR

report () {
	cat >&2 <<-'EOF'

The Docker images are now up to date.

	EOF
}

export REGISTRY="hyperd"
export BASE_DIR=$(pwd)

build() {
    cd "${BASE_DIR}/$1"

	cat >&2 <<-'EOF'

--------------------------------------------------------------


	EOF
    echo "run time: $(date) @ $(hostname)"
    echo
    echo "building image: $2"
    echo
    echo "build context: ${BASE_DIR}/$1"
    echo
# sudo mkdir -p /private/var/lib/containers
# sudo chmod -R ugo+rwx /private/var/lib/containers
    # docker run --privileged \
    #      --security-opt="seccomp=unconfined" --cap-add=ALL \
    #     -v /private/var/lib/containers/:/var/lib/containers/:rw,Z \
    #     -it -v${BASE_DIR}/$1:/build buildah/buildah sh -c "buildah bud --no-cache -t $2 /build/."
    docker build --no-cache -t $2 .
}

build base/alpine ${REGISTRY}/alpine:base
build haproxy/alpine ${REGISTRY}/haproxy:alpine

report

run() {
    docker run -p 80:5000 ${REGISTRY}/haproxy:alpine
}

run