#!/usr/bin/env bash

# Init vars
if [[ -z "$SERVICE_HAPROXY_OPTS" ]]; then SERVICE_HAPROXY_OPTS=""; fi

source /opt/docker/bin/config.sh

# createDockerStdoutStderr

includeScriptDir "/opt/docker/provision/entrypoint.d"

includeScriptDir "/opt/docker/bin/service.d/haproxy.d"

#   -W  -- "master-worker mode" (similar to the old "haproxy-systemd-wrapper"; allows for reload via "SIGUSR2")
#   -db -- disables background mode
exec /usr/sbin/haproxy -W -db $SERVICE_HAPROXY_OPTS -f /opt/docker/etc/haproxy/haproxy.cfg
