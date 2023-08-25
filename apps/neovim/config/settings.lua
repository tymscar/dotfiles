local opt = vim.opt

opt.relativenumber = true
opt.number = true

opt.tabstop = 4
opt.shiftwidth = 4
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
