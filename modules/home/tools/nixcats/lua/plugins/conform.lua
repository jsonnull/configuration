-- Conform configuration (lazy-loaded)
require("lze").load({
  {
    "conform.nvim",
    event = "BufWritePre",
    cmd = { "ConformInfo" },
    keys = {
      { "<leader>lf", desc = "Format buffer" },
    },
    after = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          nix = { "nixfmt" },
          javascript = { "prettierd" },
          javascriptreact = { "prettierd" },
          typescript = { "prettierd" },
          typescriptreact = { "prettierd" },
          json = { "prettierd" },
          jsonc = { "prettierd" },
          html = { "prettierd" },
          css = { "prettierd" },
          scss = { "prettierd" },
          markdown = { "prettierd" },
          yaml = { "prettierd" },
          svelte = { "prettierd" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })

      -- Keymap for manual formatting
      vim.keymap.set({ "n", "v" }, "<leader>lf", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end, { desc = "Format buffer" })
    end,
  },
})
