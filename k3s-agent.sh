sudo su -
export K3S_KUBECONFIG_MODE="644"
export MASTER_IP="<your-master-ip>"
export MASTER_NODE_TOKEN="<your-master-node-token>"

curl -sfL https://get.k3s.io \
  | K3S_URL="https://${MASTER_IP}:6443" \
    K3S_TOKEN="${MASTER_NODE_TOKEN}" \
    sh -

# Check for Ready node, takes ~30 seconds on control plane
sudo k3s kubectl get node
