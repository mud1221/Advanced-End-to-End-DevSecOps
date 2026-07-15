#!/bin/bash
set -euxo pipefail

# Log all output
exec > >(tee /var/log/user-data.log | logger -t user-data) 2>&1

echo "========== Starting User Data Script =========="

# -----------------------------
# Update System
# -----------------------------
apt-get update -y
apt-get upgrade -y

# -----------------------------
# Install Required Packages
# -----------------------------
apt-get install -y \
    openjdk-21-jdk \
    git \
    maven \
    unzip \
    curl \
    wget \
    gnupg \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    lsb-release

# -----------------------------
# Install Docker
# -----------------------------
curl -fsSL https://get.docker.com -o install-docker.sh
 sh install-docker.sh
 usermod -aG docker ubuntu

systemctl enable docker
systemctl start docker



# -----------------------------
# Install AWS CLI v2
# -----------------------------
cd /tmp

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
-o awscliv2.zip

unzip -o awscliv2.zip

./aws/install

# -----------------------------
# Install Terraform
# -----------------------------
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

echo \
"deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com \
$(lsb_release -cs) main" | \
tee /etc/apt/sources.list.d/hashicorp.list

apt-get update -y

apt-get install -y terraform

# -----------------------------
# Install kubectl
# -----------------------------
curl -LO \
"https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

rm kubectl

# -----------------------------
# Install eksctl
# -----------------------------
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

curl -sLO \
"https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_${PLATFORM}.tar.gz"

tar -xzf eksctl_${PLATFORM}.tar.gz -C /tmp

install -m 0755 /tmp/eksctl /usr/local/bin

rm eksctl_${PLATFORM}.tar.gz
rm /tmp/eksctl

# -----------------------------
# Install Helm
# -----------------------------
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# -----------------------------
# Install Trivy
# -----------------------------
wget -qO - \
https://aquasecurity.github.io/trivy-repo/deb/public.key | \
gpg --dearmor | \
tee /usr/share/keyrings/trivy.gpg > /dev/null

echo \
"deb [signed-by=/usr/share/keyrings/trivy.gpg] \
https://aquasecurity.github.io/trivy-repo/deb generic main" | \
tee /etc/apt/sources.list.d/trivy.list

apt-get update -y

apt-get install -y trivy

# -----------------------------
# Install Jenkins
# -----------------------------
mkdir -p /etc/apt/keyrings

wget -O /etc/apt/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo \
"deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/" | \
tee /etc/apt/sources.list.d/jenkins.list

apt-get update -y

apt-get install -y jenkins

systemctl enable jenkins
systemctl start jenkins

# -----------------------------
# SonarQube
# -----------------------------
docker pull sonarqube:lts-community

docker run -d \
--name sonarqube \
--restart unless-stopped \
-p 9000:9000 \
sonarqube:lts-community

echo "========== User Data Completed =========="