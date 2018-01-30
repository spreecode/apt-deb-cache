#!/bin/bash

set -ex

CACHE=/var/cache/apt/archives

apt-get update
apt-get install -y $*

(cd ${CACHE} && dpkg-scanpackages ./ /dev/null) | gzip -9c > ${CACHE}/Packages.gz
