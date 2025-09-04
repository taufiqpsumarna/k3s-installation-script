curl -sfL https://get.k3s.io \
| INSTALL_K3S_EXEC="server --tls-san $(curl -s ifconfig.me) --flannel-backend ipsec --disable=traefik" \
  K3S_KUBECONFIG_MODE="644" \
  sh -s -

# Check for Ready node, takes ~30 seconds

# kubectl completion
sudo apt-get install -y bash-completion
echo 'source <(kubectl completion bash)' >> ~/.bashrc
source ~/.bashrc
echo 'alias kc=kubectl' >> ~/.bashrc
echo 'complete -o default -F __start_kubectl k' >> ~/.bashrc

kubectl get nodes --all-namespaces

hostname -I | awk '{print $1}'
sudo cat /var/lib/rancher/k3s/server/node-token
echo "K3s installed"