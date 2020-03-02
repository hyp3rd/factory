# Replace markers
go-replace \
    -s "<APPLICATION_USER>" -r "$APPLICATION_USER" \
    -s "<APPLICATION_GROUP>" -r "$APPLICATION_GROUP" \
    -s "<APPLICATION_UID>" -r "$APPLICATION_UID" \
    -s "<APPLICATION_GID>" -r "$APPLICATION_GID" \
    -s "<LB_MAXCONN>" -r "$LB_MAXCONN" \
    -s "<LB_MODE>" -r "$LB_MODE" \
    -s "<LB_FRONTEND_PORT>" -r "$LB_FRONTEND_PORT" \
    -s "<LB_STRATEGY>" -r "$LB_STRATEGY" \
    --path=/opt/docker/etc/haproxy/ \
    --path-pattern='*.cfg' \
    --ignore-empty
