
set nocompatible
"filetype off
set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab

syntax on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'

Plugin 'vim-scripts/c.vim'

call vundle#end()
filetype plugin indent on


" ==== Plugin config

map <silent> <LocalLeader>nf :NERDTreeFind<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>

