#!/bin/sh

if [ "$1" = "unison" ];then
    rm -rf /elements
    ln -s /mist.core/elements /elements
fi

cd /elements
if ! git diff --quiet --exit-code master bower.json; then
    echo "bower.json changed"
    echo "Rupolynning bower install"
    GIT_DIR= bower install --config.interactive=false --allow-root
fi

exec nginx
