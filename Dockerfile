FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install openssh-server and sudo
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    iproute2 \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

# Create SSH directory
RUN mkdir /var/run/sshd

# Create user stoneflux with password stoneflux
RUN useradd -m -s /bin/bash stoneflux && \
    echo "stoneflux:stoneflux" | chpasswd && \
    echo "stoneflux ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Configure SSH for IPv4 only
RUN sed -i 's/#AddressFamily any/AddressFamily inet/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Add script to show container IPv4 at login
RUN echo '#!/bin/bash' > /etc/profile.d/show_ip.sh && \
    echo 'ip=$(hostname -I | awk "{print \$1}")' >> /etc/profile.d/show_ip.sh && \
    echo 'echo "Container IPv4 Address: $ip"' >> /etc/profile.d/show_ip.sh && \
    chmod +x /etc/profile.d/show_ip.sh

# Expose SSH port
EXPOSE 22

# Run SSH daemon on container start
CMD ["/usr/sbin/sshd", "-D"]
