-- Which-key configuration (lazy-loaded)
require("lze").load({
  {
    "which-key.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("which-key").setup({})
    end,
  },
})
