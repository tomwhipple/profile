-- Basic Neovim configuration with vim-plug

-- Plugin configuration
vim.cmd([[
call plug#begin()

" Multi-language syntax highlighting
Plug 'sheerun/vim-polyglot'

" Additional Elixir support
Plug 'elixir-editors/vim-elixir'

" Python: completion, go-to-definition, docs, rename
Plug 'davidhalter/jedi-vim'

" File tree browser
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

" Fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()
]])

-- Enable syntax highlighting
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-- Basic Vim settings
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50

-- Set leader key
vim.g.mapleader = " "

-- Telescope
local tok, tb = pcall(require, 'telescope.builtin')
if tok then
  vim.keymap.set('n', '<leader>ff', tb.find_files,  { desc = 'Find files' })
  vim.keymap.set('n', '<leader>fg', tb.live_grep,   { desc = 'Live grep' })
  vim.keymap.set('n', '<leader>fb', tb.buffers,     { desc = 'Buffers' })
  vim.keymap.set('n', '<leader>fh', tb.help_tags,   { desc = 'Help tags' })
end

-- nvim-tree
local ok, nvim_tree = pcall(require, 'nvim-tree')
if ok then
  nvim_tree.setup()
end
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true })
