-- Basic Neovim configuration with vim-plug

-- Required by nvim-tree: must be set before any plugin loads
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Plugin configuration
vim.cmd([[
call plug#begin()

" Multi-language syntax highlighting
Plug 'sheerun/vim-polyglot'

" File tree browser
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

" Fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" LSP: server management + configuration
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

" Completion engine + LSP/snippet sources
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Claude Code integration (pairs with the `claude` CLI)
Plug 'coder/claudecode.nvim'

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
  vim.keymap.set('n', '<leader>fs', tb.lsp_document_symbols, { desc = 'Document symbols' })
  vim.keymap.set('n', '<leader>fS', tb.lsp_dynamic_workspace_symbols, { desc = 'Workspace symbols' })
end

-- nvim-tree
local ok, nvim_tree = pcall(require, 'nvim-tree')
if ok then
  nvim_tree.setup({
    filters = {
      git_ignored = false,
    },
  })
end
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true })

-- LSP: servers installed and managed via mason
local servers = { 'pyright', 'lua_ls', 'bashls' }

local has_mason, mason = pcall(require, 'mason')
if has_mason then mason.setup() end

local has_mason_lsp, mason_lspconfig = pcall(require, 'mason-lspconfig')
if has_mason_lsp then
  mason_lspconfig.setup({ ensure_installed = servers })
end

-- Completion capabilities advertised to language servers (cmp adds snippet etc.)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_cmp_lsp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if has_cmp_lsp then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

-- Modern LSP API (nvim 0.11+): default configs ship in nvim-lspconfig's
-- lsp/<name>.lua files; vim.lsp.config layers per-server overrides on top,
-- vim.lsp.enable starts them.
vim.lsp.config('*', { capabilities = capabilities })

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.enable(servers)

-- Buffer-local LSP keymaps wired up via LspAttach
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end
    map('n', 'gd', vim.lsp.buf.definition,      'Go to definition')
    map('n', 'gD', vim.lsp.buf.declaration,     'Go to declaration')
    map('n', 'gi', vim.lsp.buf.implementation,  'Go to implementation')
    map('n', 'gr', vim.lsp.buf.references,      'Find references')
    map('n', 'K',  vim.lsp.buf.hover,           'Hover docs')
    map('i', '<C-k>', vim.lsp.buf.signature_help, 'Signature help')
    map('n', '<leader>rn', vim.lsp.buf.rename,  'Rename symbol')
    map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code action')
    map('n', '[d', vim.diagnostic.goto_prev,    'Prev diagnostic')
    map('n', ']d', vim.diagnostic.goto_next,    'Next diagnostic')
    map('n', '<leader>cd', vim.diagnostic.open_float, 'Diagnostic float')
  end,
})

-- Claude Code: sends buffer/selection to the `claude` CLI in a terminal split
-- and routes diff suggestions back into nvim for review. Prefix <leader>a to
-- avoid clashes with the LSP <leader>c* mappings (code action, diagnostic).
local has_claudecode, claudecode = pcall(require, 'claudecode')
if has_claudecode then
  claudecode.setup()
  vim.keymap.set('n', '<leader>ac', '<cmd>ClaudeCode<cr>',          { desc = 'Toggle Claude' })
  vim.keymap.set('n', '<leader>af', '<cmd>ClaudeCodeFocus<cr>',     { desc = 'Focus Claude pane' })
  vim.keymap.set('n', '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>',     { desc = 'Add buffer to Claude context' })
  vim.keymap.set('v', '<leader>as', '<cmd>ClaudeCodeSend<cr>',      { desc = 'Send selection to Claude' })
  vim.keymap.set('n', '<leader>al', function()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    vim.cmd(string.format('%d,%dClaudeCodeSend', line, line))
  end, { desc = 'Send current line to Claude' })
  vim.keymap.set('n', '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', { desc = 'Accept Claude diff' })
  vim.keymap.set('n', '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>',   { desc = 'Deny Claude diff' })
end

-- Completion
local has_cmp, cmp = pcall(require, 'cmp')
local has_luasnip, luasnip = pcall(require, 'luasnip')
if has_cmp then
  cmp.setup({
    snippet = {
      expand = function(args)
        if has_luasnip then luasnip.lsp_expand(args.body) end
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>']     = cmp.mapping.abort(),
      ['<CR>']      = cmp.mapping.confirm({ select = false }),
      ['<Tab>']     = cmp.mapping.select_next_item(),
      ['<S-Tab>']   = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
      { name = 'path' },
    }),
  })
end
