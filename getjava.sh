#!/bin/bash
getjava() {
    a=$(uname -m)
    case $a in
    "x86_64")
        echo Architecture $a detected.
        ;;
    *)
        echo "getjava(): Java downloads for $a is currently unavailable."
        exit
        ;;
    esac
    case $1 in
    8)
        echo Preparing download for java $1.
        ;;
    *)
        echo "getjava(): Invalid version selection: $1"
        exit
        ;;
    esac
    url="https://github.com/misaka10987/mc-server/releases/download/download/jre$1-$a.zip"
    mkdir -p ./.cache ./java &&
        touch ./.cache/jre$1.zip
    wget $url -O ./.cache/jre$1.zip &&
        unzip ./.cache/jre$1.zip -d java &&
        echo Java $1 successfully installed.
}