-- Octo configuration (lazy-loaded)
require("lze").load({
  {
    "octo.nvim",
    cmd = "Octo",
    keys = {
      { "<leader>oi", desc = "List GitHub Issues" },
      { "<leader>op", desc = "List GitHub PullRequests" },
      { "<leader>od", desc = "List GitHub Discussions" },
      { "<leader>on", desc = "List GitHub Notifications" },
      { "<leader>os", desc = "Search GitHub" },
    },
    after = function()
      require("octo").setup({
        picker = "snacks",
        enable_builtin = true,
      })

      vim.keymap.set("n", "<leader>oi", "<cmd>Octo issue list<cr>", { desc = "List GitHub Issues" })
      vim.keymap.set("n", "<leader>op", "<cmd>Octo pr list<cr>", { desc = "List GitHub PullRequests" })
      vim.keymap.set("n", "<leader>od", "<cmd>Octo discussion list<cr>", { desc = "List GitHub Discussions" })
      vim.keymap.set("n", "<leader>on", "<cmd>Octo notification list<cr>", { desc = "List GitHub Notifications" })
      vim.keymap.set("n", "<leader>os", function()
        require("octo.utils").create_base_search_command({ include_current_repo = true })
      end, { desc = "Search GitHub" })
    end,
  },
})
