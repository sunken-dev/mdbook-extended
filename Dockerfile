FROM rust:1.66.1 AS base
WORKDIR /app
RUN cargo install cargo-run-bin
COPY . .
RUN cargo bin mdbook --version

# Development
FROM base AS development
WORKDIR /app
ENTRYPOINT ["cargo", "bin",  "mdbook", "serve", "-n", "0"]
EXPOSE 3000

# Production
FROM base AS builder
WORKDIR /app
COPY . /app
RUN ["cargo", "bin",  "mdbook", "build"]
FROM nginx:1.21.6-alpine AS webserver
WORKDIR /app
COPY --from=builder /app/book/html /usr/share/nginx/html
EXPOSE 80