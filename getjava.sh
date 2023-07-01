#!/bin/bash

# checkjava <dir>
#   Checks version of java installed, 0 if not exist.
# checkjava <dir> <version>
#   Checks whether a specified java version is installed.
checkjava() {
    if (($# == 0)); then
        return 1
    fi
    if (($# > 2)); then
        return 1
    fi
    if !(test -e "$1/bin/java"); then
        echo 0 && return 0
    fi
    local version=$("$1/bin/java" -version 2>&1 | awk 'NR==1{gsub(/"/,"");print $3}')
    if (($# == 1)); then
        echo $version && return 0
    fi
    if [[ $version == $2* ]]; then
        echo true
    else
        echo false
    fi
}

# getjava <dir>
#   Updates java installation.
# getjava <dir> <version>
#   Installs a java version.
getjava() {
    if (($# == 0)); then
        return 0
    fi
    if (($# > 2)); then
        echo "getjava(): [WARN] Excess argument(s) will be ignored!"
    fi
    if !([ -d $1 ]) || [ -z $1 ]; then
        echo "getjava(): \"$1\" is not a valid directory."
        return 1
    fi
    if [ -z $2 ]; then
        local v=$(checkjava $1)
        local v=${v%%.*}
    else
        local v=$2
    fi
    local a=$(uname -m)
    case $a in
    "x86_64")
        echo "getjava(): Architecture $a detected."
        ;;
    *)
        echo "getjava(): Java for $a is currently unavailable."
        return 1
        ;;
    esac
    case $v in
    8)
        echo "getjava(): Found java $v download."
        ;;
    *)
        echo "getjava(): Java $v is currently unavailable!"
        exit
        ;;
    esac
    local url="https://github.com/misaka10987/mc-server/releases/download/download/jre$v-$a.zip"
    mkdir -p ~/.cache/mc-server $1 &&
        touch ~/.cache/mc-server/jre$v.zip
    wget $url -O ~/.cache/mc-server/jre$v.zip &&
        unzip ~/.cache/mc-server/jre$v.zip -d $1 &&
        echo "Java $v successfully installed."
}
