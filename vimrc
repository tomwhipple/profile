
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'

call vundle#end()
filetype plugin indent on


" ==== Plugin config

map <silent> <LocalLeader>nf :NERDTreeFind<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>

map <silent> <leader>ff :CommandT<CR>

