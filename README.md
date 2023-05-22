# mdbook-extended

Automatically updated [mdbook](https://github.com/rust-lang/mdBook) docker image with various extensions.

## List of extensions installed

- mdbook-toc
- mdbook-mermaid
- mdbook-admonish
- mdbook-linkcheck

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
RUN ["mdbook", "build"]

FROM nginx:alpine-slim AS webserver
COPY --from=builder /app/book/html /usr/share/nginx/html
EXPOSE 80
```
