#!/usr/bin/env bash

# Init vars
if [[ -z "$SERVICE_SUPERVISOR_OPTS" ]]; then SERVICE_SUPERVISOR_OPTS=""; fi
if [[ -z "$SERVICE_SUPERVISOR_USER" ]]; then SERVICE_SUPERVISOR_USER="application"; fi

source /opt/container/bin/config.sh

# includeScriptDir "/opt/container/bin/service.d/supervisor.d/"

exec supervisord -c /opt/container/etc/supervisor.conf --logfile /dev/null --pidfile /dev/null --user "$SERVICE_SUPERVISOR_USER" $SERVICE_SUPERVISOR_OPTS
