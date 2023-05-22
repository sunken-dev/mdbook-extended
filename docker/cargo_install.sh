#!/usr/bin/env bash
RUSTFLAGS="-C linker=$(cat .linker)" CARGO_BUILD_TARGET=$(cat .platform) cargo install --locked $1
