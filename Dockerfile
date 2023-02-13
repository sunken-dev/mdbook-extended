# syntax=docker/dockerfile:1.4
FROM --platform=$BUILDPLATFORM rust:1.67 AS builder
ARG TARGETARCH
RUN apt update && apt install -y build-essential gcc-x86-64-linux-gnu gcc-aarch64-linux-gnu
RUN export ARCH=$(case $TARGETARCH in "arm64") echo "aarch64";; *) echo "x86_64";; esac) && \
    export RUSTFLAGS="-C linker=$ARCH-linux-gnu-gcc" && \
    export CARGO_BUILD_TARGET=$ARCH-unknown-linux-gnu && \
    rustup target add $CARGO_BUILD_TARGET && \
    cargo install --locked mdbook-toc@0.9.0 && \
    cargo install --locked mdbook-mermaid@0.12.6 && \
    cargo install --locked mdbook-admonish@1.8.0  && \
    cargo install --locked mdbook-linkcheck@0.7.7  && \
    cargo install --locked mdbook-pdf@0.1.5  && \
    cargo install --locked mdbook@0.4.25 && \
    true

FROM gcr.io/distroless/cc
COPY --from=builder --link /usr/local/cargo/bin/mdbook* /usr/bin/
CMD ["mdbook", "--help"]