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
opt.mouse = "a"

opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

opt.completeopt = "menu,menuone,noselect"

vim.g.minimap_width = 10
vim.g.minimap_auto_start = 0