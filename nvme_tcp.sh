#!/bin/bash
sudo apt-get update -y && \
sudo apt-get install -y linux-modules-extra-$(uname -r) linux-generic-hwe-$(source /etc/os-release && echo $VERSION_ID) && \
sudo modprobe nvme_tcp && \
echo "nvme_tcp" | sudo tee -a /etc/modules && \
lsmod | grep nvme
