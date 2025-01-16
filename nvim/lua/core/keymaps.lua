-- keybinds
local function map(mode, ll, rr, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.api.nvim_set_keymap(mode, ll, rr, options)
end

-- System clipboard
map('v', '<leader>y', '"+y') -- yank
map('n', '<leader>p', '"+p') -- paste after cursor
map('n', '<leader>P', '"+P') -- paste before cursor

-- telescope
map('n', '<leader>ff', ':Telescope find_files<CR>') -- ff
map('n', '<leader>fg', ':Telescope live_grep<CR>') -- grep
map('n', '<leader>fb', ':Telescope buffers<CR>') -- list open buffers
map('n', '<leader>fh', ':Telescope help_tags<CR>') -- help tags

-- NvimTree
map('n', '<leader>e', ':NvimTreeToggle<CR>') -- toggle file explorer
map('n', '<leader>fe', ':NvimTreeFocus<CR>') -- focus on file explorer

-- buffer nav 
map('n', '<leader>bn', ':bnext<CR>') -- next buffer
map('n', '<leader>bp', ':bprevious<CR>') -- previous buffer
map('n', '<leader>bd', ':bdelete<CR>') -- close buffer

-- general
map('n', '<leader>w', ':w<CR>') -- save file
map('n', '<leader>q', ':q<CR>') -- quit
map('n', '<leader>qq', ':qa<CR>') -- quit
map('n', '<leader>r', ':source %<CR>') -- reload current config
