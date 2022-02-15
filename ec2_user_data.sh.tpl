#!/bin/bash

# Original script: https://cloud-backend.openvpn.com/cvpn/api/v1/scripts/VWJ1bnR1IDIwLjA0/network/ubuntu_20_04.sh
# Install the OpenVPN repository key used by the OpenVPN packages
curl -O https://swupdate.openvpn.net/repos/openvpn-repo-pkg-key.pub
sudo apt-key add openvpn-repo-pkg-key.pub && rm -f openvpn-repo-pkg-key.pub

# Add the OpenVPN repository
DISTRO=$(lsb_release -c | awk '{print $2}')
sudo curl https://swupdate.openvpn.net/community/openvpn3/repos/openvpn3-$DISTRO.list -o /etc/apt/sources.list.d/openvpn3.list
sudo apt update

# Install OpenVPN Connector setup tool
sudo apt install -y python3-openvpn-connector-setup

# Install more tools
sudo apt install -y mc gnupg unzip ca-certificates curl

# Install awscliv2
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install

# Install kubectl
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# Enable IP forwarding
sudo sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sudo sed -i 's/#net.ipv6.conf.all.forwarding=1/net.ipv6.conf.all.forwarding=1/g' /etc/sysctl.conf
sudo sysctl -p

# Configure NAT
sudo iptables -t nat -A POSTROUTING ! -o lo -j MASQUERADE
sudo ip6tables -t nat -A POSTROUTING ! -o lo -j MASQUERADE
sudo DEBIAN_FRONTEND=noninteractive apt install -y iptables-persistent

# Run openvpn-connector-setup to install ovpn profile and connect to VPN.
sudo openvpn-connector-setup --token ${openvpn_token}
