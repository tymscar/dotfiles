local opt = vim.opt

opt.relativenumber = true
opt.number = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.timeoutlen = 500
opt.expandtab = true
opt.autoindent = true

opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
vim.api.nvim_set_option("clipboard","unnamed")

opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

vim.g.minimap_width = 10
vim.g.minimap_auto_start = 0

vim.cmd("highlight minimapCursor guibg=#5b6078 guifg=#cad3f5")

vim.g.minimap_cursor_color = 'minimapCursor'
vim.g.minimap_range_color = 'Visual'
vim.g.minimap_search_color = 'Search'
vim.g.minimap_diffadd_color = 'DiffAdd'
vim.g.minimap_diffremove_color = 'DiffDelete'
vim.g.minimap_diff_color = 'DiffChange'

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
