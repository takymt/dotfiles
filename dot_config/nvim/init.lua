-- =============================================================================
-- Leader key (must be set before lazy.nvim)
-- =============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =============================================================================
-- Options
-- =============================================================================
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Behavior
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.splitright = true
opt.splitbelow = true
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 300
opt.completeopt = "menuone,noselect"

-- Disable netrw (using nvim-tree or oil instead)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- =============================================================================
-- Autocommands
-- =============================================================================
-- Soft-wrap prose filetypes at word boundaries (global default keeps wrap off)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})

-- =============================================================================
-- Keymaps
-- =============================================================================
local keymap = vim.keymap.set

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
keymap("t", "<A-h>", "<C-\\><C-n><C-w>h", { desc = "Move to left window" })
keymap("t", "<A-j>", "<C-\\><C-n><C-w>j", { desc = "Move to lower window" })
keymap("t", "<A-k>", "<C-\\><C-n><C-w>k", { desc = "Move to upper window" })
keymap("t", "<A-l>", "<C-\\><C-n><C-w>l", { desc = "Move to right window" })
keymap("t", "<C-g>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Insert mode line navigation
keymap("i", "<C-a>", "<Home>", { desc = "Move to start of line" })
keymap("i", "<C-e>", "<End>", { desc = "Move to end of line" })
-- Emacs-style kill-line: delete to end of line, or join the next line up
-- (removing the newline) when already at the end of the line.
keymap("i", "<C-k>", function()
  if vim.fn.col(".") < vim.fn.col("$") then
    return "<C-o>D"
  elseif vim.fn.line(".") < vim.fn.line("$") then
    return "<C-o>gJ"
  end
  return ""
end, { expr = true, desc = "Kill to end of line (join next line if at end)" })

-- Resize windows
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Buffer navigation
keymap("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
keymap("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Clear search highlight
keymap("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Better indenting
keymap("i", "<S-Tab>", "<C-d>", { desc = "Indent left" })
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- Move lines up/down
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Diagnostic keymaps
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
keymap("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })

-- Misc
keymap("i", "jj", "<Esc>")

-- =============================================================================
-- Bootstrap lazy.nvim
-- =============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- Load plugins
-- =============================================================================
require("lazy").setup("plugins", {
  change_detection = {
    notify = false,
  },
  rocks = {
    enabled = false,
  },
})
