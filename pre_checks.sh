#!/bin/bash

# Define absolute minimum hardware requirements for heavy AI/Docker builds
REQUIRED_RAM_MB=4000
REQUIRED_CORES=2

# Query the Linux kernel for actual available resources
AVAILABLE_RAM=$(free -m | awk '/^Mem:/{print $7}')
AVAILABLE_CORES=$(nproc)

echo "=== Executing Pre-Flight Hardware Check ==="
echo "Detected Available RAM: ${AVAILABLE_RAM}MB (Required: ${REQUIRED_RAM_MB}MB)"
echo "Detected CPU Cores: ${AVAILABLE_CORES} (Required: ${REQUIRED_CORES})"

if [ "$AVAILABLE_RAM" -lt "$REQUIRED_RAM_MB" ]; then
    echo "[FATAL ERROR] Insufficient RAM detected. Aborting pipeline to prevent Out-Of-Memory (OOM) kernel panic."
    exit 1
fi

if [ "$AVAILABLE_CORES" -lt "$REQUIRED_CORES" ]; then
    echo "[FATAL ERROR] Insufficient CPU cores. Aborting pipeline to prevent heavy throttling."
    exit 1
fi

echo "[OK] Hardware requirements met. Safe to proceed with deployment."
exit 0
