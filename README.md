# Neovim config

This is my personal Neovim configuration. It is pretty simple and was originally
based on [Modular Kickstart](https://github.com/dam9000/kickstart-modular.nvim) config.

The latest version only works with neovim 0.12+, but the old version is still available
under the `legacy` tag.

Some plugins like [fff.nvim](https://github.com/dmtrKovalenko/fff.nvim) and [blink.cmp](https://github.com/saghen/blink.cmp)
might need to be built manually, so go to the plugin directory which should be
`~/.local/share/nvim/site/pack/*/opt/`. Both plugins cited use rust so it's rather
easy to build them with `cargo build --release`.
