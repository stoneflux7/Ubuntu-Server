# Ubuntu 22.04.5 LTS
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# -----------------------------
# Install base tools
# -----------------------------
RUN apt-get update && apt-get install -y \
    sudo \
    wget \
    curl \
    git \
    nano \
    vim \
    passwd \
    net-tools \
    iproute2 \
    python3 \
    python3-pip \
    supervisor \
    gnupg2 \
    ca-certificates \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------
# Install Docker (inside container)
# -----------------------------
RUN curl -fsSL https://get.docker.com | sh \
    && usermod -aG docker root

# -----------------------------
# Users
# -----------------------------
# Root password
RUN echo "root:stoneflux" | chpasswd

# Create extra user "stoneflux"
RUN useradd -m -s /bin/bash stoneflux && echo "stoneflux:stoneflux" | chpasswd && adduser stoneflux sudo

# -----------------------------
# Hostname & Prompt
# -----------------------------
RUN echo "stoneflux" > /etc/hostname
RUN echo 'PS1="root@stoneflux:# "' >> /root/.bashrc

# -----------------------------
# Supervisor config (auto-start bash)
# -----------------------------
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# -----------------------------
# Expose port (9000, optional for web terminals)
# -----------------------------
EXPOSE 9000

# Default CMD
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
