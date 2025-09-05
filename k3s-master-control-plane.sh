#!/bin/bash
set -euo pipefail

# Detect external IP (prefer local tool over remote service)
INTERNAL_IP=$(hostname -I | awk '{print $1}')
EXTERNAL_IP=$(curl -s ifconfig.me)

# Pin K3s version (optional, safer for production)
K3S_VERSION="v1.33.4+k3s1"

# Download and verify installer
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=$K3S_VERSION \
  INSTALL_K3S_EXEC="server \
  --tls-san ${EXTERNAL_IP} \
  --write-kubeconfig-mode=644 \
  --disable=traefik" \
  sh -


# kubectl completion
sudo apt-get install -y bash-completion
echo 'source <(kubectl completion bash)' >> ~/.bashrc
echo 'alias kc=kubectl' >> ~/.bashrc
echo 'complete -o default -F __start_kubectl k' >> ~/.bashrc
source ~/.bashrc
sudo mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config

# Check for Ready node, takes ~30 seconds
kubectl get nodes --all-namespaces

# Install helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Show cluster info

kubectl cluster-info
echo "########################################"
echo "K3s Master Node Setup Complete!"
echo "Kubernetes master is running at external: https://${EXTERNAL_IP}:6443"
echo "Kubernetes master is running at internal: https://${INTERNAL_IP}:6443"
echo "K3s token for worker nodes:" $(sudo cat /var/lib/rancher/k3s/server/node-token)
echo "########################################"
