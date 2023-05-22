# mdbook-extended

Automatically updated [mdbook](https://github.com/rust-lang/mdBook) docker image with various extensions.

## List of extensions installed

- mdbook-toc
- mdbook-mermaid
- mdbook-admonish
- mdbook-linkcheck
- mdbook-pdf

## Additional preprocessors

Currently, we automatically download the files needed `mermaid` and `admonish` at build time of this base image and then in the [mdbook_build_wrapper.sh](docker/mdbook_build_wrapper.sh) we change the actual `book.toml` to load these files, to avoid downloading them on every build but only when the base image gets updated. 

## Why?

I was in need of a `mdbook` docker image to build my docs, but I always had to download the extensions separately in each docs repo I had.
So I created a base image that already has all extensions installed and can use this for all repos.
And the extensions also get auto updated in this repository.

# Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)


## Building

### Base image which contains mdbook with all extensions
```shell
docker buildx build -t sunken-dev/mdbook-extended .
```

### Example dockerfile with nginx

```Dockerfile
FROM ghcr.io/sunken-dev/mdbook-extended AS builder
COPY . .
RUN sh mdbook_build_wrapper.sh

FROM nginx:alpine-slim AS webserver
COPY --from=builder /app/book/html /usr/share/nginx/html
EXPOSE 80
```
