#!/bin/bash

set -e
set -x

TAG=test

# install
sudo docker pull busybox

sudo mkdir /tmp/test123
sudo adduser --disabled-password --gecos "" testuser
TESTUSERID=$(id -G testuser)

# make the plugin
sudo PLUGIN_TAG=$TAG make
# enable the plugin
sudo docker plugin enable lebokus/bindfs:$TAG
# list plugins
sudo docker plugin ls

# test1: simple
sudo docker volume create -d lebokus/bindfs:$TAG -o sourcePath=/tmp/test123 -o map=$TESTUSERID/0:@$TESTUSERID/@0 bindfsvolume
sudo docker run --rm -v bindfsvolume:/mnt/test busybox sh -c "echo hello > /mnt/test/world"
sudo docker run --rm -v bindfsvolume:/mnt/test busybox grep -Fxq hello /mnt/test/world
sudo docker volume rm bindfsvolume