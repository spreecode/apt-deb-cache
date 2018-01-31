# Dependency cacher

## Collect cache

    mkdir cache
    docker run --rm -v $(pwd)/cache:/app \
        spreecode/apt-deb-cache PACKAGE1 [PACKAGE2 [...]]

## Inject private package to the repo

    cp /tmp/my-private-package.deb ./cache/archives/
    docker run --rm -v $(pwd)/cache:/app spreecode/apt-deb-cache gen_pack

## Repository usage

    docker run --rm -it -v $(pwd)/cache/archives:/repo ubuntu bash

    echo 'deb file:/repo ./' > /etc/apt/sources.list
    apt-get update
    apt-get install -y --allow-unauthenticated PACKAGE1 [PACKAGE2 [...]]

## Additional repositories

You can place executable file named `init.sh` to the mounted volume root to
install additional apt sources.

Here an example file to add postgresql.org repository:

    #!/bin/sh

    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
    echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" >> /etc/apt/sources.list.d/postgresql.list
