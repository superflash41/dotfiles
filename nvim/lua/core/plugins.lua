-- load packer
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- it manages itself

    -- lsp & mason
    use 'neovim/nvim-lspconfig' -- LSP configurations
    use 'williamboman/mason.nvim' -- LSP server installer
    use 'williamboman/mason-lspconfig.nvim' -- Mason + lspconfig integration

    -- plugins here!!!
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'L3MON4D3/LuaSnip' -- Snippet engine
    use 'kyazdani42/nvim-tree.lua'

    -- git & gh
    use 'tpope/vim-fugitive'
end)
