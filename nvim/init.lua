-- Basic UI Settings
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Custom Vintage Color Scheme
vim.cmd([[
  highlight clear
  syntax reset

  set background=dark

  highlight Normal       guifg=#00FF00 guibg=#000000
  highlight Comment      guifg=#5f875f gui=italic
  highlight Constant     guifg=#ffaf00
  highlight String       guifg=#87ff5f
  highlight Identifier   guifg=#ffff5f
  highlight Function     guifg=#00ff87
  highlight Statement    guifg=#ff5f00 gui=bold
  highlight Keyword      guifg=#ff5f5f gui=bold
  highlight Type         guifg=#5fffff
  highlight PreProc      guifg=#ff87ff
  highlight Special      guifg=#ffd700
  highlight Todo         guifg=#ffffff guibg=#5f0000 gui=bold
  highlight LineNr       guifg=#5f5f5f guibg=#000000
  highlight CursorLineNr guifg=#ffff00 gui=bold
  highlight StatusLine   guifg=#00ff00 guibg=#1c1c1c
  highlight VertSplit    guifg=#444444 guibg=#000000
  highlight Pmenu        guifg=#ffffff guibg=#1c1c1c
  highlight PmenuSel     guifg=#000000 guibg=#87ff00
  highlight Visual       guibg=#005f5f
]])

-- Optional: make background transparent if your terminal supports it
-- vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")

-- Minimal plugin manager + essential plugins
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

require("lazy").setup({
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-lualine/lualine.nvim" },
})

-- Lualine (Status Bar)
require("lualine").setup({
  options = {
    theme = "auto", -- It'll adapt to our custom colors
    section_separators = '',
    component_separators = '',
  }
})

-- LSP Setup
local lspconfig = require("lspconfig")
lspconfig.pyright.setup({})
lspconfig.tsserver.setup({})

-- Treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "python", "c", "cpp", "javascript", "asm" },
  highlight = { enable = true },
})

-- Telescope
vim.api.nvim_set_keymap("n", "<Leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true })

