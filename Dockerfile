FROM rust
RUN cargo install mdbook-pdf
RUN cargo install mdbook-toc
RUN cargo install mdbook-linkcheck
RUN cargo install mdbook-admonish
RUN cargo install mdbook-mermaid
RUN cargo install mdbook
