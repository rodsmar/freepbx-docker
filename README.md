# FreePBX on Docker

## What is this ?
Multiarch FreePBX container(tested with **armv7** and **amd64**).  
This is an experimental image, probably not safe for production.

### Image includes

 * Asterisk 16
 * FreePBX 15
 * chan_dongle

### Run FreePBX image

See `docker-compose.yml`.  
  
To use **chan_dongle** enable the `devices:` section of `docker-compose.yml` also check the actual device paths on your machine(I used an udev trick to have them always have the same name, see `config/92-dongle.rules`)  

## Mini How-To Multiarch builds
There are no all-in one tutorials but you can read about multiarch builds [https://docs.docker.com/buildx/working-with-buildx/](here).  
You will also need to enable binfmt and have qemu on your system which is the harder part.  
  
If you are on docker 19.03 or later you can use the built in `buildx` or install the latest version from [https://github.com/docker/buildx/](https://github.com/docker/buildx/).  
  
A good tutorial on enabling binfmt and setting things up: [https://community.arm.com/developer/tools-software/tools/b/tools-software-ides-blog/posts/getting-started-with-docker-for-arm-on-linux](https://community.arm.com/developer/tools-software/tools/b/tools-software-ides-blog/posts/getting-started-with-docker-for-arm-on-linux).  
  
For QEMU use your distro's package or, if you are feeling adventurous(like I did), build it from source and use `checkinstall` so that it doesn't blow up your system: [https://www.qemu.org/download/](https://www.qemu.org/download/).  
I used qemu 5.0.0 for this build.

## Build

If you want to build this yourself then first run `build-base.sh` to build the base image. Check the script for the `--platform` flags you need. By default this will output `arm/v7` and `amd64`.
  
  
The FreePBX install part does not work on Qemu currently(asterisk crashes) so I manually built the last part on an `armv7` machine and then used `docker manifest` to combine it with the `amd64` version.YMMV. Tutorial on `manifest` [https://medium.com/@mauridb/docker-multi-architecture-images-365a44c26be6](https://medium.com/@mauridb/docker-multi-architecture-images-365a44c26be6)
