#!/bin/bash
# build the base msbuild image
docker build -t msbuild -f Dockerfile.msbuild .

# copy source into new image as -v does not work from mac to windows
docker build -t sources -f Dockerfile.build .

# build the binary and copy it back from windows to mac
docker rm -vf binary
docker run --name=binary sources msbuild getaddrinfo.sln /p:Configuration=Release
docker cp binary:/code/win32/Release/getaddrinfo.exe getaddrinfo.exe
