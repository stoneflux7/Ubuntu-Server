# Ubuntu 22.04.5 LTS base image
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install tools
RUN apt-get update && apt-get install -y \
    sudo \
    passwd \
    vim \
    nano \
    curl \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create user "stoneflux" (optional)
RUN useradd -m -s /bin/bash stoneflux && echo "stoneflux:stoneflux" | chpasswd && adduser stoneflux sudo

# Change root password also to "stoneflux"
RUN echo "root:stoneflux" | chpasswd

# Set hostname to stoneflux
RUN echo "stoneflux" > /etc/hostname

# Customize root prompt (remove working directory)
RUN echo 'PS1="root@stoneflux:# "' >> /root/.bashrc

# Default to root
USER root
WORKDIR /root

# Start bash
CMD ["/bin/bash"]
