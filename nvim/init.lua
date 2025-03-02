-- Bootstrap lazy.nvim (plugin manager)
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

-- Install Plugins (single setup call)
require("lazy").setup({
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" }, -- Autocompletion
  { "hrsh7th/cmp-nvim-lsp" },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-lualine/lualine.nvim" },
  { "ellisonleao/gruvbox.nvim" }, -- Include gruvbox here
})

-- Basic Settings
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.cmd("colorscheme gruvbox") -- Uncommented to apply theme

-- Lualine (Status Bar)
require("lualine").setup()

-- LSP Setup
local lspconfig = require("lspconfig")
lspconfig.pyright.setup({})  -- Python LSP
lspconfig.tsserver.setup({}) -- TypeScript LSP

-- Treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "python", "c", "cpp", "javascript", "asm" },
  highlight = { enable = true },
})

-- Telescope (Fuzzy Finder)
vim.api.nvim_set_keymap("n", "<Leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true })
