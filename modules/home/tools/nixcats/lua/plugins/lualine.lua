-- Lualine configuration
require("lualine").setup({
  options = {
    globalstatus = true,
    disabled_filetypes = {
      statusline = { "NvimTree", "startify" },
    },
  },
})
