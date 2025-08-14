
# Ubuntu Server

**Support All The Command Of The Ubuntu**

**Ipv4 Support And Ssh Server**

# Information

**Username** stoneflux

**Password** stoneflux

# Installation

```bash
  git clone https://github.com/stoneflux7/Ubuntu-Server.git
```

```bash
  docker build -t stoneflux-ubuntu-ssh . && docker run -d -p 2222:22 --name stoneflux stoneflux-ubuntu-ssh && ssh stoneflux@localhost -p 2222
```

