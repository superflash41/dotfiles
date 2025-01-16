-- leader
vim.g.mapleader = ' '

-- core config
require('core.keymaps')
require('core.options')
require('core.plugins')

-- plugin config
require('plugins.telescope')
require('plugins.treesitter')
require('plugins.nvimtree')
require('plugins.cmp')
require('plugins.lsp')








