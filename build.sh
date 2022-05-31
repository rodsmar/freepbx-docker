#!/bin/bash
TAG=$(uname -m)
docker buildx build $1 --push -t rodsmar/freepbx:16-$TAG .
