# Neovim Configuration

Personal Neovim configuration with LSP, autocompletion, and modern plugins.

## Leader Key

`<Space>` is the leader key.

## Keybindings

### General

| Key | Mode | Description |
|-----|------|-------------|
| `jk` | Insert | Exit insert mode |
| `<Esc>` | Normal | Clear search highlights |
| `<leader>e` | Normal | Toggle Neo-tree file explorer |

### Navigation (Tmux/Splits)

| Key | Mode | Description |
|-----|------|-------------|
| `<C-h>` | Normal | Navigate left (tmux/split) |
| `<C-j>` | Normal | Navigate down (tmux/split) |
| `<C-k>` | Normal | Navigate up (tmux/split) |
| `<C-l>` | Normal | Navigate right (tmux/split) |

### Telescope (Fuzzy Finder)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>sf` | Normal | Find files |
| `<leader>sg` | Normal | Live grep (search text) |
| `<leader>sb` | Normal | List open buffers |
| `<leader>sh` | Normal | Search help tags |

### Harpoon (Quick File Navigation)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>a` | Normal | Add file to harpoon |
| `<leader>m` | Normal | Toggle harpoon menu |
| `<leader>n` | Normal | Next harpoon file (cycles) |
| `<leader>p` | Normal | Previous harpoon file (cycles) |

### LSP (Language Server)

| Key | Mode | Description |
|-----|------|-------------|
| `gd` | Normal | Go to definition |
| `gr` | Normal | Go to references |
| `gI` | Normal | Go to implementation |
| `gD` | Normal | Go to declaration |
| `K` | Normal | Hover documentation |
| `<leader>D` | Normal | Type definition |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>ca` | Normal/Visual | Code action |
| `<leader>th` | Normal | Toggle inlay hints |

### Git (Gitsigns)

| Key | Mode | Description |
|-----|------|-------------|
| `]c` | Normal | Next git hunk |
| `[c` | Normal | Previous git hunk |
| `<leader>hs` | Normal | Stage hunk |
| `<leader>hr` | Normal | Reset hunk |
| `<leader>hu` | Normal | Undo stage hunk |
| `<leader>hp` | Normal | Preview hunk |
| `<leader>hb` | Normal | Blame line |

### Formatting

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>f` | Normal | Format buffer |
| (auto) | - | Format on save |

### Autocompletion (nvim-cmp)

| Key | Mode | Description |
|-----|------|-------------|
| `<C-n>` | Insert | Next completion item |
| `<C-p>` | Insert | Previous completion item |
| `<C-y>` | Insert | Confirm completion |
| `<C-Space>` | Insert | Trigger completion |
| `<C-b>` | Insert | Scroll docs up |
| `<C-f>` | Insert | Scroll docs down |
| `<C-l>` | Insert | Jump to next snippet placeholder |
| `<C-h>` | Insert | Jump to previous snippet placeholder |

## Plugins

| Plugin | Description |
|--------|-------------|
| lazy.nvim | Plugin manager |
| catppuccin | Colorscheme |
| telescope.nvim | Fuzzy finder |
| neo-tree.nvim | File explorer |
| harpoon | Quick file navigation |
| nvim-lspconfig | LSP configuration |
| mason.nvim | LSP/tool installer |
| nvim-cmp | Autocompletion |
| LuaSnip | Snippets |
| conform.nvim | Formatting |
| gitsigns.nvim | Git integration |
| nvim-treesitter | Syntax highlighting |
| vim-tmux-navigator | Tmux/split navigation |
| fidget.nvim | LSP progress indicator |
| nvim-autopairs | Auto close brackets |
| lazydev.nvim | Lua/Neovim dev support |

## LSP Servers

Installed via Mason:
- `lua_ls` - Lua
- `ts_ls` - TypeScript/JavaScript
- `terraformls` - Terraform
- `yamlls` - YAML
- `gdscript` - Godot

## File Structure

```
~/.config/nvim/
├── init.lua              # Entry point, vim options
├── lua/
│   ├── config/
│   │   ├── lazy.lua      # Lazy.nvim bootstrap
│   │   └── keymaps.lua   # Global keymaps
│   └── plugins/
│       ├── autopairs.lua
│       ├── catppuccin.lua
│       ├── cmp.lua
│       ├── conform.lua
│       ├── gitsigns.lua
│       ├── godot.lua
│       ├── harpoon.lua
│       ├── lsp-config.lua
│       ├── neo-tree.lua
│       ├── telescope.lua
│       ├── tmux-navigator.lua
│       └── treesitter.lua
```

## Commands

| Command | Description |
|---------|-------------|
| `:Lazy` | Open plugin manager |
| `:Mason` | Open LSP/tool installer |
| `:LspInfo` | Show attached LSP clients |
| `:ConformInfo` | Show formatter info |
| `:Neotree toggle` | Toggle file explorer |
