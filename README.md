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

Using the [cargo-run-bin](https://github.com/dustinblackman/cargo-run-bin) plugin, it will install all tools from the [Cargo.toml](Cargo.toml) file in the respective versions.
Versions of [Cargo.toml](Cargo.toml) are updated by a dependency update bot.

# Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)