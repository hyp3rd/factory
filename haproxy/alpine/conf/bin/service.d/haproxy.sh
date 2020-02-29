#!/usr/bin/env bash

# Init vars
if [[ -z "$SERVICE_HAPROXY_OPTS" ]]; then SERVICE_HAPROXY_OPTS=""; fi

source /opt/docker/bin/config.sh

createDockerStdoutStderr

includeScriptDir "/opt/docker/bin/service.d/haproxy.d/"

# if [[ -z ${LB_STRATEGY+x} ]]; then
#     echo ""
#     echo "[ERROR] No load balancing strategy defined in LB_STRATEGY!"
#     echo ""

#     exit 0
# fi

# if [[ -z ${LB_FRONTEND_PORT+x} ]]; then
#     echo ""
#     echo "[ERROR] No load frontend port defined in LB_FRONTEND_PORT!"
#     echo ""

#     exit 0
# fi


#   -W  -- "master-worker mode" (similar to the old "haproxy-systemd-wrapper"; allows for reload via "SIGUSR2")
#   -db -- disables background mode
exec /usr/sbin/haproxy -W -db $SERVICE_HAPROXY_OPTS -f /opt/docker/etc/haproxy/haproxy.cfg
