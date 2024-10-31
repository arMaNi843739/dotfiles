-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

-- change width size
map("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Hop (EasyMotion)
map({ "n", "v" }, "f", "<cmd>HopWord<cr>", { desc = "HopWord" })

-- comment.nvim
vim.keymap.del("n", "<c-_>")
local comment_api = require("Comment.api")
vim.keymap.set("n", "<C-_>", comment_api.toggle.linewise.current)
