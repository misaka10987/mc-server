#!/bin/bash

case $1 in
8) url="https://www.azul.com/core-post-download/?endpoint=zulu&uuid=d988583d-6848-4d56-bff5-776b2c7ac6d5" ;;
*)
    echo inst-java.sh: Invalid version selection: $1
    ;;
esac

mkdir -p ./.cache ./java &&
    touch ./.cache/jre$1.tgz
wget $url -O ./.cache/jre$1.tgz &&
    tar -zxvf ./.cache/jre$1.tgz -C ./.java &&
    mv ./java/zulu$1* ./java/$1 &&
    echo Java $1 successfully installed.
