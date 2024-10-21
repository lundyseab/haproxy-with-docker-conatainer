# Use an Ubuntu base image
FROM ubuntu:20.04

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive
ENV USER_NAME=ubuntu
ENV USER_PASS=Admin123

# Create a new user and set the password
RUN useradd -s /bin/bash -m $USER_NAME && \
    echo "$USER_NAME:$USER_PASS" | chpasswd
# Install required packages and add Docker’s official GPG key
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    git \
    && mkdir -m 0755 -p /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | tee /etc/apt/keyrings/docker.asc \
    && chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker’s repository to Apt sources
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker and required components
RUN apt-get update && apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

RUN apt-get install -y openssh-server \
    sudo \
    iputils-ping \
    net-tools \
    nano \
    vim
    
RUN usermod -aG sudo $USER_NAME \
    usermod -aG docker $USER_NAME

# Create Docker directory (Optional)
RUN mkdir -p /var/lib/docker
RUN service ssh restart
# Start Docker daemon
CMD ["dockerd"]
