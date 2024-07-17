#!/bin/bash
# Update package information and install required dependencies
sudo yum update -y
sudo yum install -y yum-utils device-mapper-persistent-data lvm2 wget unzip

# Add the Docker repository
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker
sudo yum install -y docker-ce docker-ce-cli containerd.io

# Start and enable Docker service
sudo systemctl start docker.service
sudo systemctl enable docker.service
