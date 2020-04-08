#!/usr/bin/env bash

# Link main entrypoint script to /entrypoint
ln -sf /opt/container/bin/entrypoint.sh /entrypoint

# Link entrypoint cmd shortcut conf directory to /entrypoint.cmd
ln -sf /opt/container/bin/entrypoint.d /entrypoint.cmd

# Create /entrypoint.d
mkdir -p /entrypoint.d
chmod 500 /entrypoint.d
chown root:root /entrypoint.d


