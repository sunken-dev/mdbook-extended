# mdbook-extended

Automatically updated [mdbook](https://github.com/rust-lang/mdBook) docker image with various extensions.

## List of extensions installed

- mdbook-toc
- mdbook-mermaid
- mdbook-admonish
- mdbook-linkcheck
- mdbook-pdf

## Why?

I was in need of a `mdbook` docker image to build my docs, but I always had to download the extensions separately in each docs repo I had.
So I created a base image that already has all extensions installed and can use this for all repos.
And the extensions also get auto updated in this repository.

## How does it work?

Versions of [Cargo.toml](Cargo.toml) are updated by a dependency update bot, this then triggers a rebuild of the docker image.

# Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)


## Building

### Base image which contains mdbook with all extensions
```shell
docker build -t ch4s3r/mdbook-extended .
```

### Example dockerfile with nginx

```Dockerfile
FROM ch4s3r/mdbook-extended AS builder
WORKDIR /app
COPY . .
RUN ["mdbook", "build"]

FROM nginx:alpine AS webserver
COPY --from=builder /app/book/html /usr/share/nginx/html
EXPOSE 80
```