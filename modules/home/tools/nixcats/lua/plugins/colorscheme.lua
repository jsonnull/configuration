-- Colorscheme configuration
require("kanso").setup({
  bold = true,
  italics = true,
  undercurl = true,
  transparent = false,
  dimInactive = false,
  terminalColors = true,
  foreground = {
    dark = "saturated",
    light = "saturated",
  },
})

-- Load the zen variant (deep & rich dark theme)
vim.cmd("colorscheme kanso-zen")
