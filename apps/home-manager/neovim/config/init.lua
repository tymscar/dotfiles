local modules = {
  "settings",
  "colourscheme",
  "keymaps",
  "plugins.comment",
  "plugins.nvim-tree",
  "plugins.lualine",
  "plugins.telescope",
  "plugins.whichkey",
  "plugins.lsp",
  "plugins.cmp",
  "plugins.treesitter",
  "plugins.gitsigns",
  "plugins.neogit",
}

for _, mod in ipairs(modules) do
  local ok, err = pcall(require, mod)
  if not ok then
    vim.notify("Failed to load " .. mod .. ": " .. err, vim.log.levels.WARN)
  end
end
