# Dependency cacher

## Collect cache

    mkdir cache
    docker run --rm -v $(pwd)/cache:/var/cache/apt/archives \
        spreecode/apt-deb-cache:latest PACKAGE1 [PACKAGE2 [...]]

## Repository usage

    docker run --rm -it -v $(pwd)/cache:/repo ubuntu bash

    echo 'deb file:/repo ./' > /etc/apt/sources.list
    apt-get install -y --allow-unauthenticated PACKAGE1 [PACKAGE2 [...]]