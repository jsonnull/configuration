-- nvim-tree.lua
----------------

--vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' }
--vim.g.nvim_tree_auto_ignore_ft = { 'startify' }

local opts = {
    noremap = true,
    silent = false,
    expr = false,
}

vim.api.nvim_set_keymap('n', '<c-n>', ":NvimTreeToggle<cr>", opts)

-- NERDTree
----------------

vim.api.nvim_set_keymap('n', '<c-n>', ":NERDTreeToggle<cr>", opts)

vim.g.NERDTreeIgnore = { 'node_modules', '.git$', '.coverage', 'flow-typed', 'built', 'dist' }
vim.g.NERDTreeMinimalUI = 1
