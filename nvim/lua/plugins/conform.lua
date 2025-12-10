return {
  "stevearc/conform.nvim",
  opts = {
    format_on_save = function(bufnr)
      -- Disable autoformat for .vue files
      if vim.bo[bufnr].filetype == "vue" then
        return
      end
      return { timeout_ms = 500, lsp_format = "fallback" }
    end,
  },
}
