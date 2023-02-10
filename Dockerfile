# syntax=docker/dockerfile:1.4
FROM rust:1.67 AS builder
RUN cargo install mdbook-toc       --locked --version "0.11.0"
RUN cargo install mdbook-mermaid   --locked --version "0.12.6"
RUN cargo install mdbook-admonish  --locked --version "1.8.0"
RUN cargo install mdbook-linkcheck --locked --version "0.7.7"
RUN cargo install mdbook-pdf       --locked --version "0.1.5"
RUN cargo install mdbook           --locked --version "0.4.25"

FROM gcr.io/distroless/cc
COPY --from=builder --link /usr/local/cargo/bin/mdbook* /usr/bin/
CMD ["mdbook", "--version"]
