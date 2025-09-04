# 🚀 K3s Cluster Setup (Master + Agent)

This repository contains two scripts to help you set up a **lightweight Kubernetes (K3s)** cluster with a control plane and agent nodes.

---

## 📌 Scripts

### 1. `k3s-master-control-plane.sh`

Bootstraps the **control plane (server)** with:

* TLS SAN set to your external IP (detected automatically via `ifconfig.me`)
* Flannel backend set to **IPsec** for encrypted overlays
* Traefik disabled
* `kubectl` auto-completion and alias setup (`kc` as shortcut)

**Usage:**

```bash
chmod +x k3s-master-control-plane.sh
./k3s-master-control-plane.sh
```

After installation:

* Get node status:

  ```bash
  kubectl get nodes --all-namespaces
  ```
* Get your node token for joining agents:

  ```bash
  sudo cat /var/lib/rancher/k3s/server/node-token
  ```

---

### 2. `k3s-agent.sh`

Joins a **worker (agent) node** to your master.

Update the placeholders in the script:

* `<your-master-ip>`
* `<your-master-node-token>` (from the server node)

**Usage:**

```bash
chmod +x k3s-agent.sh
./k3s-agent.sh
```

Check readiness (\~30 seconds later):

```bash
sudo k3s kubectl get node
```

---

## ⚙️ Requirements

* Linux host(s) with root or sudo access
* Open port `6443` between master and agents
* `bash-completion` installed for autocompletion
* Supported OS (Ubuntu, Debian, CentOS, etc.)

---

## ✅ Notes

* `kubectl` completion and alias (`kc`) are added to `~/.bashrc`.
* Make sure each node has a unique hostname.
* Replace dynamic IP (`ifconfig.me`) with a static IP or DNS if running in production.
* For multiple control plane nodes (HA setup), you’ll need an external datastore (etcd, MySQL, PostgreSQL).

---

## 📖 References

* [K3s Docs – Quick Start](https://docs.k3s.io/quick-start)
* [K3s Docs – Installation Options](https://docs.k3s.io/installation/configuration)
* [K3s Docs – Cluster Access](https://docs.k3s.io/cluster-access)

---

👉 Would you like me to **merge both scripts into a single README + two separate files in the gist**, or just prepare a one-file Gist with instructions inline for both master and agent setup?
