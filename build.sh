#!/bin/bash
# build the base msbuild image
docker build -t msbuild -f Dockerfile.msbuild .

# copy source into new image as -v does not work from mac to windows
docker build -t build -f Dockerfile.build .

# build the binary and copy it back from windows to mac
docker rm -vf binary
docker run --name=binary build
docker cp binary:/code/win32/Debug/getaddrinfo.exe getaddrinfo.exe
