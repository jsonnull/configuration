local opts = {
    noremap = true,
    silent = true,
}

-- buffers
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<cr>', opts)
-- TODO: Add telescope session here
vim.api.nvim_set_keymap('n', '<leader>w', '<cmd>Bdelete<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>Bwipeout<cr>', opts)

vim.api.nvim_set_keymap('n', 'Y', 'yy', opts)

-- navigation
vim.api.nvim_set_keymap('n', '<leader>h', ':noh<cr>', opts)

