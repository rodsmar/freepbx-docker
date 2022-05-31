#!/bin/bash

arch=(x86_64 armv7l aarch64)
for tag in "${arch[@]}"
do
    docker pull rodsmar/freepbx:16-${tag}
done

docker manifest create rodsmar/freepbx:16 "${arch[@]/#/rodsmar/freepbx:15-}"
docker manifest push --purge rodsmar/freepbx:16

docker pull rodsmar/freepbx:16
docker tag rodsmar/freepbx:16 rodsmar/freepbx:latest
