#!/bin/bash

case $1 in
"forge-1.12.2") url="https://catserver.moe/download/universal" ;;
*)
    echo inst.sh: Invalid version selection: $1
    ;;
esac

mkdir -p ./forge-1.12.2 &&
    touch ./forge-1.12.2/server.jar
wget $url -O ./forge-1.12.2/server.jar &&
    echo Minecraft server for $1 successfully installed.
