#!/usr/bin/env bash

# go-replace --mode=line --regex --regex-backrefs \
#     -s '^([ \t]*local2)[ \t]*([^\t ;]+)(.*;)$' -r '$1 /docker.stdout $3' \
#     # -s '^([ \t]**local2.)[ \t]*([^\t ;]+)(.*;)$' -r '$1 /docker.stderr $3' \
#     --  /opt/docker/etc/haproxy/haproxy.cfg

# Clear logs
rm -rf /var/log/haproxy.log
touch /var/log/haproxy.log

# Set log to stdout/stderr
ln -sf /var/log/haproxy.log /docker.stdout
ln -sf /var/log/haproxy.log /docker.stderr
