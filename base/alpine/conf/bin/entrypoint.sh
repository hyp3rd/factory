#!/usr/bin/env bash

if [[ -z "$CONTAINER_UID" ]]; then
    export CONTAINER_UID="application"
fi

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

trap 'echo sigterm ; exit' SIGTERM
trap 'echo sigkill ; exit' SIGKILL

source /opt/docker/bin/config.sh

# createDockerStdoutStderr

#############################
## COMMAND
#############################

runEntrypoints "$@"