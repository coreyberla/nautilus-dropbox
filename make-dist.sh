#!/bin/bash

# Generate the nautilus-dropbox-$VERSION.tar.bz2 source tarball from a
# configured meson build directory. meson dist can't produce bzip2 tarballs,
# so generate a gzip tarball and recompress it.
#
# Usage: ./make-dist.sh BUILDDIR
#
# The tarball is written to BUILDDIR/meson-dist/.

set -euo pipefail

BUILDDIR=$1
CURVER=$(meson introspect --projectinfo "$BUILDDIR" | python3 -c 'import json, sys; print(json.load(sys.stdin)["version"])')
TARBALL=$BUILDDIR/meson-dist/nautilus-dropbox-$CURVER

meson dist -C "$BUILDDIR" --formats gztar --no-tests
gzip -dc "$TARBALL.tar.gz" | bzip2 -9 > "$TARBALL.tar.bz2"
rm -f "$TARBALL.tar.gz" "$TARBALL.tar.gz.sha256sum"
