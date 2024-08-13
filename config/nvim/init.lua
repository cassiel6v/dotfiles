--   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
--   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
--   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
--   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
--   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
--   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--   macOS/personal configuration

-----------------
--  CONTENTS
-----------------

-- MISC
-- SETTINGS :: 00-functionality; 01-UI; 02-editing; 03-undo & backup; 04-folds
-- REMAPS :: 05-normal; 06-visual
-- PLUGINS :: 07-autocompile; 08-packer & plugins (plenary, lualine, colorizer, nvim-tree, telescope, rose-pine)

-----------------
--  MISC
-----------------

local g = vim.g
local o = vim.opt
local c = vim.cmd

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

c.colorscheme "rose-pine"

-----------------
--  SETTINGS
-----------------

-- 00 • functionality

o.timeoutlen = 500
o.updatetime = 200
o.clipboard = 'unnamedplus'

-- 01 • UI

o.splitright = true
o.splitbelow = true
o.termguicolors = true
o.scrolloff = 8
o.number = true
o.relativenumber = true
o.numberwidth = 5
o.cursorline = false
o.jumpoptions = 'view'
o.cursorline = true
o.cursorcolumn = true
o.cmdheight = 2
o.pumheight = 10

-- 02 • editing

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
o.mouse = "a"
o.textwidth = 300
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.list = true
o.listchars = 'nbsp:◇,extends:▸,precedes:◂'

-- 03 • undo & backup

o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false
o.backupdir = '/tmp/'
o.directory = '/tmp/'
o.undodir = '/tmp/'
o.history = 50

-- 04 • folds

o.foldmethod = 'indent'
o.foldlevelstart = 99
o.foldnestmax = 3
o.foldminlines = 1

--------------------
--  REMAPS
--------------------

local function map(m, k, v)
    vim.keymap.set(m, k, v, { noremap = true, silent = true })
end

--- leader key

map('', '<Space>', '<Nop>')
g.mapleader = ' '
g.maplocalleader = ' '

-- 05 • normal

--map('n', '<leader>e', ':Lex 25<CR>')
map('n', '<leader>e', ':NvimTreeToggle<CR>')
map('n', '<leader>c', ':ColorizerToggle<CR>')
map('n', '<leader>p', ':PackerSync<CR>')

map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', 'Y', 'y$')
map('n', 'L', '$')
map('n', 'H', '^')
map('n', 'dL', 'd$')
map('n', 'dH', 'd^')
map('n', 'x', '"_x')

map('n', 'J', '<CMD>move .+1<CR>')
map('n', 'K', '<CMD>move .-2<CR>')

map('n', '<C-Up>', ':resize +2<CR>')
map('n', '<C-Down>', ':resize -2<CR>')
map('n', '<C-Left>', ':vertical resize -2<CR>')
map('n', '<C-Right>', ':vetical resize +2<CR>')

-- 06 • visual

map('v', '<', '<gv')
map('v', '>', '>gv')

map('v', 'p', '"_dP')

map('x', 'J', ":move '>+1<CR>gv=gv")
map('x', 'K', ":move '<-2<CR>gv=gv")
map('x', 'L', '$')
map('x', 'H', '^')

---------------
--  PLUGINS
---------------

-- 07 • autocompile

vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'init.lua',
    command = 'source <afile> | PackerCompile',
})

-- 08 • packer & plugins

return require('packer').startup({
        function(use)
    use('wbthomason/packer.nvim')

    --- plenary (required)
    
    use('nvim-lua/plenary.nvim')
    
    --- lualine
    
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    require('lualine').setup()
    
    --- colorizer
    
    use('norcalli/nvim-colorizer.lua')
    
    --- nvim-tree
    
    use {
      'nvim-tree/nvim-tree.lua',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true },
   }   

   require('nvim-tree').setup()
    
    --- rose-pine

    use { "rose-pine/neovim", as = "rose-pine" }

    --- end ---

    end,
        config = {
            display = {
                open_fn = function()
                    return require('packer.util').float({ border = 'single' })
                end,
            },
        },
})
