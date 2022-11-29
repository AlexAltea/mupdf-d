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
os_type=$(uname -s)

wget --no-clobber https://mupdf.com/downloads/archive/mupdf-$version-source.tar.gz
tar xfz mupdf-$version-source.tar.gz --skip-old-files
dub run dpp -- source/mupdf.dpp \
    --preprocess-only \
    --hard-fail \
    --function-macros \
    --source-output-path="generated/$version/${os_type}" \
    --include-path="$(pwd)/mupdf-$version-source/include"
