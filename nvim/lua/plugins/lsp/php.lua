return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      phpactor = {
        enabled = lsp == "phpactor",
      },
      intelephense = {
        enabled = lsp == "intelephense",
      },
      [lsp] = {
        enabled = true,
      },
    },
  },
}
