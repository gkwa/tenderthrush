#!/usr/bin/env bash
set -e
set -x
set -u

# Debug: Check network and DNS are working with defaults
echo === Testing default network and DNS configuration ===
echo Current DNS config:
cat /etc/resolv.conf
echo Network interfaces:
ip addr show
echo Testing connectivity to external servers:
ping -c 1 8.8.8.8
echo Testing DNS resolution:
host archive.ubuntu.com || echo host command not available, will test via apt

# Update package list
apt-get update

# Install prerequisites
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" |
    tee /etc/apt/sources.list.d/docker.list >/dev/null

# Update package list with Docker repo
apt-get update

# Install Docker
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Docker service
systemctl enable docker
systemctl start docker

# Add ubuntu user to docker group if it exists
if id ubuntu &>/dev/null; then
    usermod -aG docker ubuntu
fi

# Test Docker installation
docker --version
docker info

echo Docker installation completed successfully
