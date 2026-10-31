#!/bin/bash

set -euxo pipefail

rm -rf build

# Build deb packages.
for DISTRO in ubuntu debian debian_i386; do
    docker build --pull -t nautilus-dropbox/$DISTRO -f Dockerfile.$DISTRO .
    docker run -u "$(id -u):$(id -g)" -v `pwd`:/src nautilus-dropbox/$DISTRO ./generate-deb.sh
done

# Build fedora rpm.
docker build -t nautilus-dropbox/fedora -f Dockerfile.fedora .
docker run -u "$(id -u):$(id -g)" -v `pwd`:/src nautilus-dropbox/fedora ./generate-rpm.sh

# Build the source tarball and the standalone dropbox script.
docker run -u "$(id -u):$(id -g)" -v `pwd`:/src nautilus-dropbox/fedora sh -c \
    "meson setup build/meson && meson compile -C build/meson dropbox && ./make-dist.sh build/meson"
mkdir -p build/packages
cp build/meson/dropbox build/packages/dropbox.py
cp build/meson/meson-dist/nautilus-dropbox-*.tar.bz2 build/packages/
