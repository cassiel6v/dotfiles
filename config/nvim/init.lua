--   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
--   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
--   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
--   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
--   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
--   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--   macOS Configuration

-----------------
--   CONTENTS
-----------------
-- MISC
-- SETTINGS :: Functionality | UI | Editing | Undo&Backup | Folds
-- REMAPS :: Normal | Visual
-- PLUGINS :: Autocompile | Packer | Plugins :: Plenary | Lualine | Colorizer | Nvim-Tree | Telescope | Rose-Pine

-----------------
--   MISC
-----------------

local g = vim.g
local o = vim.opt
local c = vim.cmd

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

c.colorscheme "rose-pine"


-----------------
--   SETTINGS
-----------------

-- •• Functionality

o.timeoutlen = 500
o.updatetime = 200
o.clipboard = 'unnamedplus'

-- •• UI

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

-- •• Editing

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

-- •• Undo&Backup

o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false
o.backupdir = '/tmp/'
o.directory = '/tmp/'
o.undodir = '/tmp/'
o.history = 50

-- •• Folds

o.foldmethod = 'indent'
o.foldlevelstart = 99
o.foldnestmax = 3
o.foldminlines = 1

--------------------
--   REMAPS
--------------------

local function map(m, k, v)
    vim.keymap.set(m, k, v, { noremap = true, silent = true })
end

-- •• Leader

map('', '<Space>', '<Nop>')
g.mapleader = ' '
g.maplocalleader = ' '

-- •• Normal

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

-- •• Visual

map('v', '<', '<gv')
map('v', '>', '>gv')

map('x', 'J', ":move '>+1<CR>gv=gv")
map('x', 'K', ":move '<-2<CR>gv=gv")
map('x', 'L', '$')
map('x', 'H', '^')

map('x', 'p', '"_dDP')


---------------
--  PLUGINS
---------------

-- •• Autocompile

vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'init.lua',
    command = 'source <afile> | PackerCompile',
})

-- •• Packer

return require('packer').startup({
        function(use)
    use('wbthomason/packer.nvim')

-- •• Plugins

    --- Plenary (required)
    
    use('nvim-lua/plenary.nvim')
    
    --- Lualine
    
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    require('lualine').setup()
    
    --- Colorizer
    
    use('norcalli/nvim-colorizer.lua')
    
    --- Nvim-Tree
    
    use {
      'nvim-tree/nvim-tree.lua',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true },
   }   

   require('nvim-tree').setup()
    
    --- Rose-Pine

    use { "rose-pine/neovim", as = "rose-pine" }

    --- End ---

    end,
        config = {
            display = {
                open_fn = function()
                    return require('packer.util').float({ border = 'single' })
                end,
            },
        },
})
