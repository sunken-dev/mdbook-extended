# syntax=docker/dockerfile:1.4
FROM --platform=$BUILDPLATFORM rust:1.69-slim AS builder
SHELL ["/bin/bash", "-c"]
WORKDIR /app
ARG TARGETARCH
RUN apt-get update && apt-get install -y build-essential gcc-x86-64-linux-gnu gcc-aarch64-linux-gnu
RUN rustup target add x86_64-unknown-linux-gnu x86_64-unknown-linux-gnu aarch64-unknown-linux-gnu
ENV CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER=x86_64-linux-gnu-gcc
ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-linux-gnu-gcc
ARG amd64=x86_64-unknown-linux-gnu
ARG arm64=aarch64-unknown-linux-gnu
ENV CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse

FROM builder AS mdbook-toc
RUN cargo install --target ${!TARGETARCH} --locked mdbook-toc@0.11.0

FROM builder AS mdbook-mermaid
RUN cargo install --target ${!TARGETARCH} --locked mdbook-mermaid@0.12.6

FROM builder AS mdbook-admonish
RUN cargo install --target ${!TARGETARCH} --locked mdbook-admonish@1.8.0

FROM builder AS mdbook-linkcheck
RUN cargo install --target ${!TARGETARCH} --locked mdbook-linkcheck@0.7.7

FROM builder AS mdbook
RUN cargo install --target ${!TARGETARCH} --locked mdbook@0.4.25

FROM debian:stable-slim
WORKDIR /app
COPY --from=mdbook-toc       --link /usr/local/cargo/bin/mdbook* /usr/bin/
COPY --from=mdbook-mermaid   --link /usr/local/cargo/bin/mdbook* /usr/bin/
COPY --from=mdbook-admonish  --link /usr/local/cargo/bin/mdbook* /usr/bin/
COPY --from=mdbook-linkcheck --link /usr/local/cargo/bin/mdbook* /usr/bin/
COPY --from=mdbook           --link /usr/local/cargo/bin/mdbook* /usr/bin/
ENTRYPOINT ["mdbook"]
CMD ["--help"]
