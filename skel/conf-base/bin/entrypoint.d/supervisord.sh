#!/usr/bin/env bash

#############################################
## Supervisord (start daemons)
#############################################

## Start services
exec /opt/container/bin/service.d/supervisor.sh

