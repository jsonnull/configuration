-- nvim-bufferline.lua
----------------------

local cmd = vim.cmd
local nord = require('nord.colors')

require("bufferline").setup {
  options = {
    numbers = "buffer_id",
    offsets = {{filetype = "NvimTree", text = "", padding = 1}},
    tab_size = 22,
    show_tab_indicators = true,
    enforce_regular_tabs = false,
    view = "multiwindow",
    separator_style = "thick",
  }
}
