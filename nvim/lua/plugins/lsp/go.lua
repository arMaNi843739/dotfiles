return {
  -- ... 既存のLSP関連の設定 ...
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          -- 提案の設定をここに追加
          settings = {
            gopls = {
              hints = {
                -- package comment の警告を無効化
                package = false,
              },
            },
          },
          -- LazyVim Extras の設定とマージされる
        },
      },
    },
  },
  -- ...
}
