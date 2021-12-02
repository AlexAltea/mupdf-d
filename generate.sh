#!/usr/bin/env bash

# Abort on errors
set -euo pipefail

# Usage
if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <version>"
    echo "  - version: MuPDF version to generate bindings for"
    echo "Example: $0 1.19.0"
    exit 0
fi

# Install specific version
version=$1
wget https://mupdf.com/downloads/archive/mupdf-$version-source.tar.gz
tar xfz mupdf-$version-source.tar.gz
make -C mupdf-$version-source -j$(nproc) HAVE_X11=no HAVE_GLUT=no
dub run dpp -- source/mupdf.dpp --preprocess-only --no-sys-headers \
    --include-path="$(pwd)/mupdf-$version-source/include"
