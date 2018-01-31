#!/bin/bash

set -ex

APT_CACHE=/var/cache/apt/archives
APP=/app
ARCHIVES=${APP}/archives

mkdir -p ${ARCHIVES}
[[ -x ${APP}/init.sh ]] && ${APP}/init.sh

install() {
    apt-get update
    apt-get install -y --allow-unauthenticated $*
    cp ${APT_CACHE}/*.deb ${ARCHIVES}
}

gen_pack() {
    cd ${ARCHIVES}
    dpkg-scanpackages ./ /dev/null | gzip -9c > Packages.gz
}

case $1 in
gen_pack)
    gen_pack;;
install)
    shift;&
*)
    install $* && gen_pack;;
esac