------------------------
--   BASE SETTINGS
------------------------

local g = vim.g
local o = vim.o

-- Functionality
o.timeoutlen = 500
o.updatetime = 200
o.clipboard = 'unnamedplus'

-- UI
o.splitright = true
o.splitbelow = true
o.termguicolors = true
o.scrolloff = 8
o.number = true
o.relativenumber = true
o.numberwidth = 5
o.cursorline = false
o.jumpoptions = 'view'

-- Editing
o.expandtab = true
o.smarttab = true
o.smartcase = true
o.ignorecase = true
o.cindent = true
o.smartindent = true
o.wrap = true
o.linebreak = true
o.ruler = true
o.incsearch = true
o.mouse = a
o.textwidth = 300
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.list = true
o.listchars = 'nbsp:◇,extends:▸,precedes:◂'

-- Undo and Backup
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false
o.backupdir = '/tmp/'
o.directory = '/tmp/'
o.undodir = '/tmp/'
o.history = 50

-- Folds
o.foldmethod = 'indent'
o.foldlevelstart = 99
o.foldnestmax = 3
o.foldminlines = 1

-- Map <leader> to space
g.mapleader = ' '
g.maplocalleader = ' '
