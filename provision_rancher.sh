#!/bin/bash

set -e

# Install Git, Python3, Pip
DEBIAN_FRONTEND=noninteractive sudo apt-get install -y git python3 python3-pip

# Pull and run Rancher
sudo docker pull rancher/rancher:latest
docker run -d --name rancher --privileged -d --restart=unless-stopped -v /opt/rancher:/var/lib/rancher -p 80:80 -p 443:443 rancher/rancher
