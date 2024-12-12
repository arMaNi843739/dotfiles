-- vim.g.preview_markdown_auto_update = 1

return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,

    keys = {
      { "<leader>tmv", "<cmd>Markview splitToggle<cr>", desc = "Toggle split markdown preview." },
    },

    dependencies = {
      -- You will not need this if you installed the
      -- parsers manually
      -- Or if the parsers are in your $RUNTIMEPATH
      "nvim-treesitter/nvim-treesitter",

      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      vim.cmd([[highlight MarkviewHeading1 guibg=#E67E80 guifg=white]])
      vim.cmd([[highlight MarkviewHeading2 guibg=#EB9C5F guifg=white]])
      vim.cmd([[highlight MarkviewHeading3 guibg=#83C092 guifg=white]])
      vim.cmd([[highlight MarkviewHeading4 guibg=#7FBBB3 guifg=white]])
      vim.cmd([[highlight MarkviewHeading5 guibg=#D3C6AA guifg=white]])
      vim.cmd([[highlight MarkviewHeading6 guibg=#384B55 guifg=white]])
      vim.cmd([[highlight MarkviewCode guibg=#1e2326]])
    end,
  },
}
