# Installation

****

```bash
git clone https://github.com/stoneflux7/Ubuntu-Server.git && docker build -t stoneflux . && docker run -it --name stoneflux-container stoneflux && docker run -it -p 9000:9000 --name stoneflux-container stoneflux
```

**Start And Stop And Restart**

**Start**
```bash
docker start -ai stoneflux-container
```

**Stop**
```bash
docker stop stoneflux-container
```

**Restart**
```bash
docker restart -ai stoneflux-container
```
