-- Telescope configuration (lazy-loaded)
require("lze").load({
  {
    "telescope.nvim",
    cmd = { "Telescope" },
    keys = {
      { "<c-t>", desc = "LSP Workspace Symbols" },
    },
    after = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = require("telescope.actions").close,
            },
          },
        },
      })
      pcall(telescope.load_extension, "fzf")
      vim.keymap.set("n", "<c-t>", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "LSP Workspace Symbols" })
    end,
  },
  -- fzf extension loads when telescope loads
  {
    "telescope-fzf-native.nvim",
    on_plugin = { "telescope.nvim" },
  },
})
