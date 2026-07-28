#!/bin/bash
set -e

# Update the system
sudo apt update -y
sudo apt upgrade -y

# Install required packages
sudo apt install -y \
openjdk-21-jdk \
git \
curl \
wget \
unzip \
docker.io \
maven \
apt-transport-https \
ca-certificates \
gnupg \
lsb-release

# Start and enable Docker
sudo systemctl enable docker
sudo systemctl start docker

# Add users to Docker group
sudo usermod -aG docker ubuntu

# -----------------------------
# Install Jenkins
# -----------------------------
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | \
sudo tee /usr/share/keyrings/jenkins-keyring.asc >/dev/null

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | \
sudo tee /etc/apt/sources.list.d/jenkins.list >/dev/null

sudo apt update -y
sudo apt install -y jenkins

sudo systemctl enable jenkins
sudo systemctl start jenkins

# -----------------------------
# Install AWS CLI v2
# -----------------------------
cd /tmp

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip

unzip -q awscliv2.zip

sudo ./aws/install

# -----------------------------
# Install kubectl
# -----------------------------
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl

sudo mv kubectl /usr/local/bin/

# -----------------------------
# Install eksctl
# -----------------------------
curl --silent --location \
"https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | \
tar xz -C /tmp

sudo mv /tmp/eksctl /usr/local/bin/

# -----------------------------
# Install Helm
# -----------------------------
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Give Jenkins Docker access
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu
# Restart services
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl restart jenkins

# -----------------------------
# Display installed versions
# -----------------------------
echo "=============================="
echo "Installed Versions"
echo "=============================="

java -version
mvn -version
docker --version
aws --version
kubectl version --client
eksctl version
helm version

echo "=============================="
echo "Setup Completed Successfully!"
echo "=============================="