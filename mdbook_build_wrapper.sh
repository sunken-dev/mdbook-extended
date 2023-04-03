toml set book.toml preprocessor.mermaid.command "mdbook-mermaid"
toml set book.toml output.html.additional-js "[mermaid.min.js, mermaid-init.js]"
toml set book.toml preprocessor.admonish.command "mdbook-admonish"
toml set book.toml preprocessor.admonish.assets_version `cat admonish_assets_version`
toml set book.toml output.html.additional-css "mdbook-admonish.css"
mdbook build
