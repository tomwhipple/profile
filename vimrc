
set nocompatible
"filetype off
set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab

syntax on

"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"
"" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'
"
"Plugin 'scrooloose/nerdtree'
"
"Plugin 'vim-scripts/c.vim'
"
"call vundle#end()
"filetype plugin indent on

call plug#begin()

Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

"Plug 'ahmedkhalf/jupyter-nvim', { 'do': ':UpdateRemotePlugins' }

"lua << EOF
" require("jupyter-nvim").setup {
" }
"EOF

call plug#end()

" ==== Plugin config

map <silent> <LocalLeader>nf :NERDTreeFind<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>



