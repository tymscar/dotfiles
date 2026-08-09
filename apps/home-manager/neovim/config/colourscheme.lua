local ok, catppuccin = pcall(require, "catppuccin")
if not ok then
  return
end

catppuccin.setup({
  flavour = "mocha",
  integrations = {
    cmp = true,
    gitsigns = true,
    neogit = true,
    nvimtree = true,
    telescope = { enabled = true },
    treesitter = true,
    which_key = true,
    native_lsp = { enabled = true },
  },
  custom_highlights = function(colors)
    return {
      MiniMapCursor = { fg = colors.text, bg = colors.surface1 },
    }
  end,
})

vim.cmd.colorscheme("catppuccin-mocha")

vim.g.minimap_cursor_color = "MiniMapCursor"
vim.g.minimap_range_color = "Visual"
vim.g.minimap_search_color = "Search"
vim.g.minimap_diffadd_color = "DiffAdd"
vim.g.minimap_diffremove_color = "DiffDelete"
vim.g.minimap_diff_color = "DiffChange"
