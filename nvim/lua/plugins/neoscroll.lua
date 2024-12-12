return {
  "karb94/neoscroll.nvim",
  config = function()
    require("neoscroll").setup({
      mappings = { "<C-u>", "<C-d>", "zt", "zz", "zb" },
    })

    local t = {}
    local time = "85"
    t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", time } }
    t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", time } }
    t["zt"] = { "zt", { time } }
    t["zz"] = { "zz", { time } }
    t["zb"] = { "zb", { time } }

    require("neoscroll.config").set_mappings(t)
  end,
}
