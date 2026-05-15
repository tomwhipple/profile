# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles whose goal is a **consistent terminal environment across machines** — primarily the zsh shell, tmux, and Neovim configs. Cloned into `~/profile` and activated via `./setup.sh`. The shell entry point is `zshrc` (zsh + oh-my-zsh); `bash_profile` and `archived_tools` are retained as reference but not symlinked by `setup.sh`.

Because the same configs run on multiple machines (currently macOS Apple Silicon and Linux), changes should preserve portability — see "Cross-platform considerations" below.

## How activation works

`setup.sh` is idempotent and works by symlinking files from this repo into `$HOME`:
- `tmux.conf` → `~/.tmux.conf`
- `zshrc` → `~/.zshrc`
- `nvim/init.lua` → `~/.config/nvim/init.lua`

It also bootstraps external dependencies on first run:
- oh-my-zsh (via the upstream installer, with `RUNZSH=no CHSH=no`)
- oh-my-zsh custom plugins referenced in `zshrc` (currently `zsh-direnv`) — add new third-party plugins to the `clone_omz_plugin` calls in `setup.sh` when adding them to the `plugins=(...)` line in `zshrc`
- vim-plug for nvim, followed by a headless `:PlugInstall`
- Legacy Vundle for vim (only kept for the rare case vim is invoked directly; `aliases` aliases `vim` → `nvim` when nvim is present)

When editing `zshrc` or `nvim/init.lua`, the change takes effect immediately because the files in `$HOME` are symlinks — no re-run of `setup.sh` is required. `setup.sh` only needs to run again when adding a new file that needs linking or a new third-party plugin that needs cloning.

## Cross-platform considerations

The shell config is used on both macOS (Apple Silicon, primary) and Linux. Guard platform-specific bits behind existence checks rather than `$OSTYPE` branches where possible:
- Homebrew shellenv is gated on `/opt/homebrew/bin/brew` existing (see `zshrc`, `bash_profile`).
- `pbcopy`/`pbpaste` aliases in `aliases` only activate on Linux when `xclip` is available; macOS has them natively.
- `SUDO_ASKPASS` is only exported when the Linux-only `gnome-ssh-askpass` binary is present.

Follow this pattern for any new tooling: detect, don't assume.

## Neovim plugin changes

Plugins are declared inside the `vim.cmd([[ call plug#begin() ... call plug#end() ]])` block in `nvim/init.lua`. After adding a `Plug` line, run `:PlugInstall` inside nvim (or `nvim --headless +PlugInstall +qall`). `vim.g.loaded_netrw` / `loaded_netrwPlugin` are set to `1` before plugin load — this is required for `nvim-tree` and must stay at the top of the file.

## LSP

LSP is wired up via `neovim/nvim-lspconfig` + `mason.nvim` + `mason-lspconfig.nvim`, with completion through `nvim-cmp` (sources: `cmp-nvim-lsp`, `cmp-buffer`, `cmp-path`, `LuaSnip` via `cmp_luasnip`).

- Servers are listed in the `servers` table in `init.lua` and installed automatically by `mason-lspconfig`'s `ensure_installed` on first startup (current set: `pyright`, `lua_ls`, `bashls`). To add a server: append its lspconfig name to that table and, if it needs custom settings, add an entry to `server_opts`.
- Buffer-local LSP keymaps live in the `on_attach` function — `gd`/`gD`/`gi`/`gr`, `K`, `<leader>rn`, `<leader>ca`, `[d`/`]d`. Telescope adds `<leader>fs`/`<leader>fS` for document/workspace symbols.
- Mason downloads server binaries per-platform under `~/.local/share/nvim/mason/`, which preserves portability across macOS and Linux. The host needs the usual build tools mason depends on (`git`, `curl`, `unzip`, plus a C toolchain for some servers).
- On a fresh machine: `setup.sh`'s headless `:PlugInstall` pulls the plugins; the first interactive `nvim` launch triggers mason to install the servers (monitor with `:Mason`).
- Elixir syntax is provided by `vim-polyglot` (no Elixir LSP is configured by default — add `elixirls` to `servers` if needed).

## Claude Code in Neovim

`coder/claudecode.nvim` is loaded in `init.lua` and pairs with the host's `claude` CLI — it boots a Claude session in a terminal split, lets you push the current buffer/selection/line as context, and round-trips proposed diffs back into nvim for accept/deny. Keymaps live under the `<leader>a` prefix to avoid clashing with the LSP `<leader>c*` mappings:

- `<leader>ac` — toggle the Claude pane
- `<leader>af` — focus the Claude pane
- `<leader>ab` — add the current buffer to Claude's context
- `<leader>as` — (visual) send the selection to Claude
- `<leader>al` — send the current line to Claude
- `<leader>aa` / `<leader>ad` — accept / deny a proposed diff

The plugin requires the `claude` CLI to be on PATH; it's not installed by `setup.sh`. If `claude` is missing, the plugin still loads but the commands won't have anywhere to talk to.

## Things to leave alone

- `archived_tools` and `bash_profile` are not sourced by the active zsh setup. They're kept as a paste-from reference for legacy environments (asdf, pyenv, rbenv, gcloud, heroku, CUDA, etc.). Don't wire them back in unless asked.
- `git-completion.bash` is only used by `bash_profile`'s fallback path. Zsh's git completion comes from oh-my-zsh's `git` plugin.
