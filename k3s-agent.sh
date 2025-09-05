#!/bin/bash
set -euo pipefail

### CONFIG ###
MASTER_IP=""
MASTER_NODE_TOKEN=""
K3S_VERSION="v1.33.4+k3s1"

### Install K3s Agent ###
echo "[INFO] Installing K3s Agent..."
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=$K3S_VERSION \
  K3S_URL="https://${MASTER_IP}:6443" \
  K3S_TOKEN="${MASTER_NODE_TOKEN}" \
  sh -

### Wait for Node Registration ###
echo "[INFO] Waiting for agent node to join the cluster..."
sleep 30

### Verify Agent Node Locally ###
if sudo k3s kubectl get node "$(hostname)" &>/dev/null; then
  echo "[SUCCESS] Node $(hostname) has joined the cluster."
else
  echo "[ERROR] Node $(hostname) did not register properly."
  exit 1
fi
