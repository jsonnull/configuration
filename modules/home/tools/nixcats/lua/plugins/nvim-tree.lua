-- NvimTree configuration (lazy-loaded)
require("lze").load({
  {
    "nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus" },
    keys = {
      { "<c-n>", desc = "Toggle NvimTree" },
    },
    after = function()
      require("nvim-tree").setup({
        filters = {
          custom = {
            ".direnv",
            ".git/",
            "node_modules",
            ".cache",
          },
        },
        view = {
          width = 40,
        },
        git = {
          ignore = false,
        },
        renderer = {
          group_empty = true,
        },
      })
      vim.keymap.set("n", "<c-n>", ":NvimTreeToggle<cr>", { silent = true, desc = "Toggle NvimTree" })
    end,
  },
})
