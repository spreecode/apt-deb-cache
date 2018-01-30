#!/bin/bash

set -ex

CACHE=/var/cache/apt/archives


install() {
    apt-get update
    apt-get install -y $*
}

gen_pack() {
    cd ${CACHE}
    dpkg-scanpackages ./ /dev/null | gzip -9c > ${CACHE}/Packages.gz
}

case $1 in
gen_pack)
    gen_pack;;
*)
    install $* && gen_pack;;
esac