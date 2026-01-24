-- Bufdelete configuration (lazy-loaded)
require("lze").load({
  {
    "bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
    keys = {
      { "<leader>w", desc = "Delete buffer" },
      { "<leader>q", desc = "Wipeout buffer" },
    },
    after = function()
      vim.keymap.set("n", "<leader>w", "<cmd>Bdelete<cr>", { desc = "Delete buffer" })
      vim.keymap.set("n", "<leader>q", "<cmd>Bwipeout<cr>", { desc = "Wipeout buffer" })
    end,
  },
})
