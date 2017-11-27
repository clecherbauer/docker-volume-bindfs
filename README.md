# Docker volume plugin for bindfs
This project is based on vieux/docker-volume-sshfs and currently a "work-in-progress"

## Usage

1 - Install the plugin

```
$ docker plugin install lebokus/bindfs

# or to enable debug 
docker plugin install lebokus/bindfs DEBUG=1

# or to change where plugin state is stored
docker plugin install lebokus/bindfs state.source=<any_folder>
```

2 - Create a volume

```
$ docker volume create -d lebokus/bindfs -o sourcePath=./ [-o <any_bindfs_-o_option> ] bindfsvolume

$ docker volume ls
DRIVER              VOLUME NAME
local               2d75de358a70ba469ac968ee852efd4234b9118b7722ee26a1c5a90dcaea6751
local               842a765a9bb11e234642c933b3dfc702dee32b73e0cf7305239436a145b89017
local               9d72c664cbd20512d4e3d5bb9b39ed11e4a632c386447461d48ed84731e44034
local               be9632386a2d396d438c9707e261f86fd9f5e72a7319417901d84041c8f14a4d
local               e1496dfe4fa27b39121e4383d1b16a0a7510f0de89f05b336aab3c0deb4dda0e
lebokus/bindfs      bindfsvolume
```

3 - Use the volume

```
$ docker run -it -v bindfsvolume:<path> busybox ls <path>
```

## LICENSE

MIT
