local opts = {
    noremap = true,
    silent = true,
}

-- buffers
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<cr>', opts)

-- navigation
vim.api.nvim_set_keymap('n', '<leader>h', ':noh<cr>', opts)
