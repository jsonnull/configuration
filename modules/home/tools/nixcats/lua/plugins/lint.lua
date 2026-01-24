-- nvim-lint configuration (lazy-loaded)
require("lze").load({
  {
    "nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    after = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        bash = { "shellcheck" },
        sh = { "shellcheck" },
        nix = { "statix" },
      }

      -- Autocommand to trigger linting
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
})
