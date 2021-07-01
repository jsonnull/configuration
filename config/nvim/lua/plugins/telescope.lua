require('telescope').load_extension('session-lens')
require('telescope').load_extension('heading')

local opts = {
    noremap = true,
    silent = false,
    expr = false,
}

vim.api.nvim_set_keymap('n', '<c-p>', "<cmd>Telescope find_files<cr>", opts)
vim.api.nvim_set_keymap('n', '<c-e>', "<cmd>Telescope live_grep<cr>", opts)

local actions = require('telescope.actions')
require('telescope').setup({
    defaults = {
        mappings = {
            i = {
                ['<esc>'] = actions.close,
            },
        },
    },
})


