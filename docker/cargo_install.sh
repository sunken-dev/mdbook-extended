#!/usr/bin/env bash
set -euxo pipefail
RUSTFLAGS="-C linker=$(cat .linker)" CARGO_BUILD_TARGET=$(cat .platform) cargo install --locked $1
