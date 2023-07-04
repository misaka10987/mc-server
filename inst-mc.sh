#!/bin/bash

set -e
source ./config.sh
source ./getjava.sh

src="https://github.com/misaka10987/mc-server/releases/download/download"

if (($# == 0)); then
    echo "inst-mc.sh <version>"
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
    echo "inst-mc.sh: invalid version \"$1\"!"
    ;;
esac

mkdir -p "~/.mc-server/.java" "./mc-server"
ln -s "~/.mc-server" "./mc-server"

if [ -z "$java" ]; then
    getjava "~/.mc-server/.java" $java_version
elif [ $(checkjava "$java") == 0 ]; then
    echo "inst-mc.sh: \"$java\" has not java installation!"
    exit 1
elif !(`checkjava "$java" $java_version`); then
    echo "inst-mc.sh: java version in \"$java\" is $(checkjava "$java"), needs ${java_version}!"
    exit 1
else
    ln -s "$java" "~/.mc-server/.java/${java_version}"
fi
unset java
echo "inst-mc.sh: java is ready."

mkdir -p "~/.mc-server/$1"
ln -s "~/.mc-server/.java/${java_version}/bin/java" "~/.mc-server/$1/java"
touch "~/.mc-server/$1/server.jar"
wget "${src}/$1.jar" -O "./$1/server.jar"
echo "inst-mc.sh: minecraft server \"$1\" successfully installed."

if $frp; then
    mkdir -p "~/.mc-server/.frp"
    touch "~/.mc-server/frp/frpc" "~/.mc-server/frp/frpc.ini"
    wget "${src}/frpc" -O "~/.mc-server/frp/frpc"
    wget "${src}/frpc.ini" -O "~/.mc-server/frp/frpc.ini"
    echo "inst-mc.sh: frpc successfully installed. Check \`frpc.ini\` to use."
fi

unset src java_version