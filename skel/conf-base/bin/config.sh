#!/usr/bin/env bash

set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value
set -o errtrace

shopt -s nullglob

###
 # Check if current user is root
 #
 ##
function rootCheck() {
    # Root check
    if [ "$(/usr/bin/whoami)" != "root" ]; then
        echo "[ERROR] $* must be run as root"
        exit 1
    fi
}

###
 # Create /container.stdout and /container.stderr
 #
 ##
function createDockerStdoutStderr() {
    # link stdout from docker
    if [[ -n "$LOG_STDOUT" ]]; then
        echo "Log stdout redirected to $LOG_STDOUT"
    else
        LOG_STDOUT="/proc/$$/fd/1"
    fi

    if [[ -n "$LOG_STDERR" ]]; then
        echo "Log stderr redirected to $LOG_STDERR"
    else
        LOG_STDERR="/proc/$$/fd/2"
    fi

    ln -f -s "$LOG_STDOUT" /container.stdout
    ln -f -s "$LOG_STDERR" /container.stderr
}
###
 # Include script directory text inside a file
 #
 # $1 -> path
 #
 ##
function includeScriptDir() {
    if [[ -d "$1" ]]; then
        for FILE in "$1"/*.sh; do
            echo "-> Executing ${FILE}"
            # run custom scripts, only once
            . "$FILE"
        done
    fi
}

###
 # Show deprecation notice
 #
 ##
function deprecationNotice() {
    echo ""
    echo "###############################################################################"
    echo "###      THIS CALL IS DEPRECATED AND WILL BE REMOVED IN THE FUTURE"
    echo "###"
    echo "### $*"
    echo "###"
    echo "###############################################################################"
    echo ""
}

###
 # Run "entrypoint" scripts
 ##
function runEntrypoints() {
    ###############
    # Try to find entrypoint
    ###############

    ENTRYPOINT_SCRIPT="/opt/container/bin/entrypoint.d/${TASK}.sh"

    if [ -f "$ENTRYPOINT_SCRIPT" ]; then
        . "$ENTRYPOINT_SCRIPT"
    fi

    ###############
    # Run default
    ###############
    if [ -f "/opt/container/bin/entrypoint.d/default.sh" ]; then
        . /opt/container/bin/entrypoint.d/default.sh
    fi

    exit 1
}

 # Run "entrypoint" provisioning
 ##
function runProvisionEntrypoint() {
    includeScriptDir "/opt/container/provision/entrypoint.d"
    includeScriptDir "/entrypoint.d"
}

###
 # List environment variables (based on prefix)
 ##
function envListVars() {
    if [[ $# -eq 1 ]]; then
        env | grep "^${1}" | cut -d= -f1
    else
        env | cut -d= -f1
    fi
}

###
 # Get environment variable (even with dots in name)
 #
 ##
function envGetValue() {
    awk "BEGIN {print ENVIRON[\"$1\"]}"
}
