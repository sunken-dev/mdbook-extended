#!/usr/bin/env bash
set -euxo pipefail
case $TARGETARCH in
  "amd64")
    echo "x86_64-unknown-linux-gnu" > .platform
    echo "gcc-x86-64-linux-gnu" > .compiler
    echo "x86_64-linux-gnu-gcc" > .linker
    ;;
  "arm64")
    echo "aarch64-unknown-linux-gnu" > .platform
    echo "gcc-aarch64-linux-gnu" > .compiler
    echo "aarch64-linux-gnu-gcc" > .linker
    ;;
esac
