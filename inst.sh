#!/bin/bash
source ./getjava.sh
case $1 in
"forge-1.12.2")
    java=8
    ;;
*)
    echo inst.sh: Invalid version selection: $1
    ;;
esac
url="https://github.com/misaka10987/mc-server/releases/download/download/$1"
getjava $java
mkdir -p ./$1 &&
    touch ./$1/server.jar
wget $url -O ./$1/server.jar &&
    echo Minecraft server for $1 successfully installed.
