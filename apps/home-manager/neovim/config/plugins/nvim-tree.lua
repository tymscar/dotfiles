vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local ok, nvimtree = pcall(require, "nvim-tree")
if not ok then
  return
end

nvimtree.setup()