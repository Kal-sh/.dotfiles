# Podman Containers

## List

### jdownloader-2

```bash
podman run -d \
--name=jdownloader-2 \
-p 5800:5800 \
-v ~/Downloads/jdownloader/config:/config:rw \
-v ~/Downloads/jdownloader/downloads:/output:rw \
docker.io/jlesage/jdownloader-2
```

### qBittorrents

```bash
 podman run -d \
  --name=qbittorrent \
  --net=host \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -v ~/Downloads/torrents:/downloads \
  -v ~/Downloads/torrents:/config \
  -p 8080:8080 \
  -p 6881:6881 \
  -p 6881:6881/udp \
  --restart unless-stopped \
  lscr.io/linuxserver/qbittorrent:latest
```

### Plex

```bash
 podman run -d \
  --name=plex \
  --net=host \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e VERSION=podman \
  -v ~/Downloads/plex/library:/config \
  -v ~/Downloads/plex/tvseries:/tv \
  -v ~/Downloads/plex/movies:/movies \
  -v ~/big_D/system:/others \
  --restart unless-stopped \
  lscr.io/linuxserver/plex:latest
```

### Deemix - deezer music downloader

```bash
podman run -d --name Deemix \
  -v ~/Downloads/Deemix:/downloads \
  -v ~/Downloads/Deemix:/config \
  -p 6595:6595 \
  ghcr.io/bambanah/deemix:latest
```

### mysql container

```bash
podman run -d --name mysql-local -e MYSQL_ROOT_PASSWORD=1234 -p 3306:3306 docker.io/library/mysql:latest
```

### postgres container

```bash
podman run -d --name postgres-local -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=1234 -p 5432:5432 docker.io/library/postgres:latest
```
