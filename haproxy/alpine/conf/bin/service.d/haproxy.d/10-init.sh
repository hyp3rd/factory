if [[ -z ${LB_STRATEGY+x} ]]; then
    echo ""
    echo "[ERROR] No load balancing strategy defined in LB_STRATEGY!"
    echo ""

    exit 0
fi

if [[ -z ${LB_FRONTEND_PORT+x} ]]; then
    echo ""
    echo "[ERROR] No load frontend port defined in LB_FRONTEND_PORT!"
    echo ""

    exit 0
fi
