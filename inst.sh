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

if [ -z $java ]; then
    mkdir -p ./java
    getjava ./java $java_version
elif [ $(checkjava $java) == 0 ]; then
    echo "inst.sh: \"$java\" has not java installation!"
    exit 1
elif !(`checkjava $java $java_version`); then
    echo "inst.sh: java version in \"$java\" is $(checkjava $java), while $java_version is needed!"
    exit 1
else
    ln -s $java ./java/$java_version
fi
echo "inst.sh: java is ready."

mkdir -p ./$1
touch ./$1/server.jar
wget "https://github.com/misaka10987/mc-server/releases/download/download/$1.jar" -O ./$1/server.jar
echo "inst.sh: minecraft server \"$1\" successfully installed."

if $frp; then
    mkdir -p ./frp
    touch ./frp/frpc ./frp/frpc.ini
    wget https://github.com/misaka10987/mc-server/releases/download/download/frpc -O ./frp/frpc
    wget https://github.com/misaka10987/mc-server/releases/download/download/frpc.ini -O ./frp/frpc.ini
    echo "inst.sh: frpc successfully installed. Check ./frp/frpc.ini to use."
fi

touch ./$1/launch.sh
echo "#!/bin/bash">./$1/launch.sh
echo "source ../config.sh">>./$1/launch.sh
echo "java=$java_version">>./$1/launch.sh
echo "\"../java/\$java/bin/java\" -jar -Xmx\${memory}M ./server.jar  ">>./$1/launch.sh
chmod +x ./$1/launch.sh