-- nvim-tree.lua
----------------

vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' }
vim.g.nvim_tree_auto_ignore_ft = { 'startify' }

local opts = {
    noremap = true,
    silent = false,
    expr = false,
}

vim.api.nvim_set_keymap('n', '<c-n>', ":NvimTreeToggle<cr>", opts)
