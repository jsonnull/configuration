-- Snacks configuration
require("snacks").setup({
  bigfile = { enabled = true },
  quickfile = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
})

-- Keymaps
vim.keymap.set("n", "<leader>b", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>p", function() Snacks.picker.git_files() end, { desc = "Git Files" })
vim.keymap.set("n", "<leader>g", function() Snacks.picker.grep() end, { desc = "Grep" })
