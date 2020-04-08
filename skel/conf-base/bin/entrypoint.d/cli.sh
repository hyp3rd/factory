#!/usr/bin/env bash

#############################################
## Run CLI_SCRIPT from environment variable
#############################################

if [ -n "${CLI_SCRIPT}" ]; then
    exec ${CLI_SCRIPT} "$@"
else
    echo "[ERROR] No CLI_SCRIPT in in docker environment defined"
    exit 1
fi
