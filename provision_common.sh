#!/bin/bash

set -e

sudo apt-get update -y
sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common \
  gnupg-agent \
  python3-pip

# Add Docker GPG key and repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker vagrant

# Install Docker Compose via pip
sudo pip3 install docker-compose

# Disable UFW if it's enabled
if command -v ufw >/dev/null 2>&1; then
  sudo ufw disable
fi

# Allow all traffic on the private network (optional but safer)
sudo iptables -A INPUT -s 192.168.56.0/24 -j ACCEPT