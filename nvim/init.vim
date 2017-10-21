call plug#begin('~/.local/share/nvim/plugged')

Plug 'roxma/nvim-completion-manager'
Plug 'roxma/ncm-clang'
Plug 'dafufer/nvim-cm-swift-completer'
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neco-syntax'

call plug#end()

execute pathogen#infect()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
