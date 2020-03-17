#!/usr/bin/env bash

# Init vars
if [[ -z "${SERVICE_SYSLOG_OPTS+x}" ]]; then SERVICE_SYSLOG_OPTS=""; fi
if [[ -z "${SYSLOGNG_OPTS+x}" ]]; then SYSLOGNG_OPTS="--no-caps"; fi

source /opt/docker/bin/config.sh

includeScriptDir "/opt/docker/bin/service.d/syslog-ng.d/"

exec syslog-ng -F --no-caps -p /var/run/syslog-ng.pid $SYSLOGNG_OPTS $SERVICE_SYSLOG_OPTS
