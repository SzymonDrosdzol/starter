-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Custom keymaps

vim.keymap.set("n", "<leader>yr", function()
  local root = LazyVim.root()
  local file = vim.api.nvim_buf_get_name(0)
  local path = vim.fn.fnamemodify(file, ":.")
  if root and file:find("^" .. vim.pesc(root)) then
    path = file:sub(#root + 2)
  end
  vim.fn.setreg("+", path)
  vim.notify(path)
end, { desc = "Yank project-relative file path" })

local search_scope = require("util.search_scope")

vim.keymap.set("n", "<leader>sg", search_scope.grep, { desc = "Grep (Search Scope)" })
vim.keymap.set("n", "<leader>sF", search_scope.set, { desc = "Set Search Scope" })
vim.keymap.set("n", "<leader>sS", search_scope.show, { desc = "Show Search Scope" })
vim.keymap.set("n", "<leader>sX", search_scope.clear, { desc = "Clear Search Scope" })
