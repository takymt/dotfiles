# Neovim Configuration

> Leader key = **Space**

## File Navigation

| Key                              | Action               |
| -------------------------------- | -------------------- |
| `<leader>e`                      | Toggle file explorer |
| `<leader>ff`                     | Find files           |
| `<leader>fg`                     | Live grep search     |
| `<leader>fb` / `<leader><space>` | List buffers         |

## Window & Buffer

| Key                   | Action               |
| --------------------- | -------------------- |
| `Ctrl` + `h/j/k/l`    | Move between windows |
| `Ctrl` + `Arrow keys` | Resize windows       |
| `Shift` + `h`         | Previous buffer      |
| `Shift` + `l`         | Next buffer          |
| `<leader>bd`          | Delete buffer        |

## LSP

| Key          | Action                |
| ------------ | --------------------- |
| `gd`         | Go to definition      |
| `gr`         | Go to references      |
| `gI`         | Go to implementation  |
| `gy`         | Go to type definition |
| `gD`         | Go to declaration     |
| `K`          | Hover documentation   |
| `<leader>rn` | Rename symbol         |
| `<leader>ca` | Code action           |
| `<leader>ds` | Document symbols      |
| `<leader>ws` | Workspace symbols     |
| `[d` / `]d`  | Prev/Next diagnostic  |
| `<leader>d`  | Show diagnostic float |
| `<leader>q`  | Diagnostic list       |

## Formatting

| Key          | Action        |
| ------------ | ------------- |
| `<leader>cf` | Format buffer |

Configured formatters:

| Filetype                | Formatter priority                   |
| ----------------------- | ------------------------------------ |
| Lua                     | `stylua`                             |
| JavaScript / TypeScript | `oxfmt`, `biome`, `prettier`         |
| Astro                   | `oxfmt`, `biome`, `prettier`         |
| JSON / YAML / Markdown  | `dprint`, `prettier`                 |
| Go                      | `gofumpt`, `goimports`               |
| Python                  | `ruff_format`, or `isort` + `black`  |
| Rust                    | `rustfmt`                            |

## Completion

| Key                | Action            |
| ------------------ | ----------------- |
| `Ctrl` + `j/n`     | Next item         |
| `Ctrl` + `k/p`     | Previous item     |
| `Enter`            | Confirm selection |

## Editing

| Key       | Action                         |
| --------- | ------------------------------ |
| `<` / `>` | Indent in visual mode          |
| `J` / `K` | Move selected lines up or down |

## Discovery

| Key         | Action                         |
| ----------- | ------------------------------ |
| `<leader>?` | Show buffer-local keybindings  |

## Core Plugins

| Category   | Plugins                              |
| ---------- | ------------------------------------ |
| LSP        | `mason`, `nvim-lspconfig`            |
| Formatting | `conform`                            |
| Completion | `nvim-cmp`                           |
| Navigation | `telescope`, `nvim-tree`             |
| Git        | `gitsigns`                           |
| UI         | `lualine`, `bufferline`, `which-key` |
| Theme      | `tokyonight`                         |
| Syntax     | `nvim-treesitter`                    |
