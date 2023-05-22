# syntax=docker/dockerfile:1.4
FROM --platform=$BUILDPLATFORM rust:1.69-slim AS builder
WORKDIR /app
ARG TARGETARCH
ENV CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse
COPY ./docker/platform.sh ./docker/cargo_install.sh ./
RUN sh platform.sh
RUN apt-get update && apt-get install -y build-essential $(cat .compiler)
RUN rustup target add $(cat .platform)

FROM builder AS mdbook-toc
RUN sh cargo_install.sh mdbook-toc@0.11.0

FROM builder AS mdbook-mermaid
RUN sh cargo_install.sh mdbook-mermaid@0.12.6

FROM builder AS mdbook-admonish
RUN sh cargo_install.sh mdbook-admonish@1.8.0

FROM builder AS mdbook-linkcheck
RUN sh cargo_install.sh mdbook-linkcheck@0.7.7

FROM builder AS mdbook
RUN sh cargo_install.sh mdbook@0.4.25

FROM builder AS toml-cli
RUN sh cargo_install.sh toml-cli@0.2.3

FROM debian:stable-slim
WORKDIR /app
COPY --from=mdbook-toc       --link /usr/local/cargo/bin/mdbook* /usr/bin/
COPY --from=mdbook-mermaid   --link /usr/local/cargo/bin/mdbook* /usr/bin/
COPY --from=mdbook-admonish  --link /usr/local/cargo/bin/mdbook* /usr/bin/
COPY --from=mdbook-linkcheck --link /usr/local/cargo/bin/mdbook* /usr/bin/
COPY --from=mdbook           --link /usr/local/cargo/bin/mdbook* /usr/bin/
COPY --from=toml-cli         --link /usr/local/cargo/bin/toml*   /usr/bin/
RUN mdbook init --title none --ignore none
RUN mdbook-mermaid install
RUN mdbook-admonish install
RUN toml get book.toml preprocessor.admonish.assets_version > .admonish_assets_version
COPY ./docker/mdbook_build_wrapper.sh .
ENTRYPOINT ["mdbook"]
CMD ["--help"]
