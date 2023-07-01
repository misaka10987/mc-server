#!/bin/bash

set -e
source ./config.sh
source ./getjava.sh

if (($# == 0)); then
    echo "inst.sh <version>"
    exit
fi

if (($# > 1)); then
    echo "getjava(): [WARN] Excess argument(s) will be ignored!"
fi

case $1 in
"forge-1.12.2")
    java=$java8
    java_version=8
    ;;
*)
    echo "inst.sh: invalid version \"$1\"!"
    ;;
esac

if [ -z java ]; then
    mkdir -p ./java
    getjava ./java $java_version
elif [ $(checkjava $java) == 0 ]; then
    echo "inst.sh: \"$java\" has not java installation!"
    exit 1
elif !(`checkjava $java $java_version`); then
    echo "inst.sh: java version in \"$java\" is $(checkjava $java), while $java_version is needed!"
    exit 1
fi
echo "inst.sh: java is ready."

url="https://github.com/misaka10987/mc-server/releases/download/download/$1.jar"

mkdir -p ./$1 &&
    touch ./$1/server.jar
wget $url -O ./$1/server.jar &&
    echo "inst.sh: minecraft server \"$1\" successfully installed."
