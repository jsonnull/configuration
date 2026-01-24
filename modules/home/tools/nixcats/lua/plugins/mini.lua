-- mini.nvim configuration (lazy-loaded)
require("lze").load({
  {
    "mini.nvim",
    event = "BufReadPost",
    after = function()
      require("mini.comment").setup({})
      require("mini.surround").setup({})
    end,
  },
})
