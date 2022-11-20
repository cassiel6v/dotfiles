---------------
--  PLUGINS
---------------

-- •• Packer

-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile',
})

return require('packer').startup({
        function(use)
    use('wbthomason/packer.nvim')

    -- •• Plenary (required)
    
    use('nvim-lua/plenary.nvim')
    
    -- •• Lualine
    
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    
    -- •• Colorizer
    
    use('norcalli/nvim-colorizer.lua')
    
    -- •• Nvim-Tree
    
    use('nvim-tree/nvim-tree.lua')
    
    -- •• Telescope
    
--     use {
--       'nvim-telescope/telescope.nvim', tag = '0.1.0',
--       requires = { {'nvim-lua/plenary.nvim'} }
--       requires = { 'nvim-telescope/telescope-fzf-native.nvim', opt = true }
--       requires = { 'nvim-telescope/telescope-symbols.nvim', opt = true }
--     }

-- Rosé Pine

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })
    
    end,
        config = {
            display = {
                open_fn = function()
                    return require('packer.util').float({ border = 'single' })
                end,
            },
        },
})
