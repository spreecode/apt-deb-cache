# Dependency cacher

## Collect cache

    mkdir cache
    docker run --rm -v $(pwd)/cache:/var/cache/apt/archives \
        spreecode/apt-deb-cache PACKAGE1 [PACKAGE2 [...]]

## Inject private package to the repo

    cp /tmp/my-private-package.deb ./cache/
    docker run --rm -v $(pwd)/cache:/var/cache/apt/archives \
        spreecode/apt-deb-cache gen_pack

## Repository usage

    docker run --rm -it -v $(pwd)/cache:/repo ubuntu bash

    echo 'deb file:/repo ./' > /etc/apt/sources.list
    apt-get update
    apt-get install -y --allow-unauthenticated PACKAGE1 [PACKAGE2 [...]]
