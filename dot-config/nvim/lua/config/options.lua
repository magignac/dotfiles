vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.opt.laststatus = 3
vim.opt.numberwidth = 4

-- general
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.lazyredraw = true
vim.opt.cursorline = true

vim.opt.errorbells = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'

vim.opt.cmdheight = 2

vim.opt.updatetime = 50

vim.opt.shortmess:append('c')

vim.opt.colorcolumn = '120'

vim.opt.hidden = true
vim.opt.encoding = 'utf-8'

vim.opt.completeopt = 'menu'
