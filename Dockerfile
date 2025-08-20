# Ubuntu 22.04.5 LTS
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install base tools + KasmVNC dependencies
RUN apt-get update && apt-get install -y \
    sudo \
    wget \
    curl \
    git \
    nano \
    vim \
    passwd \
    net-tools \
    lxde \
    supervisor \
    openssh-client \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Create root password = stoneflux
RUN echo "root:stoneflux" | chpasswd

# Set hostname
RUN echo "stoneflux" > /etc/hostname

# Clone your GitHub repo (replace with your repo URL)
RUN git clone https://github.com/stoneflux/your-repository.git /opt/app

# Install KasmVNC (headless desktop over port 6080)
RUN wget https://github.com/kasmtech/KasmVNC/releases/download/v1.2.0/kasmvncserver_1.2.0_amd64.deb \
    && apt-get update && apt-get install -y ./kasmvncserver_1.2.0_amd64.deb \
    && rm kasmvncserver_1.2.0_amd64.deb

# Fix bash prompt to root@stoneflux:#
RUN echo 'PS1="root@stoneflux:# "' >> /root/.bashrc

# Expose KasmVNC web port
EXPOSE 6080

# Set working dir to repo
WORKDIR /opt/app

# Start KasmVNC when container runs
CMD ["/usr/bin/kasmvncserver", "--vnc", ":1", "--listen", "0.0.0.0", "--http-port", "6080"]
