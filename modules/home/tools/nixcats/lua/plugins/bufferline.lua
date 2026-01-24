-- Bufferline configuration
require("bufferline").setup({
  options = {
    offsets = {
      {
        filetype = "bufferlist",
        text = "Explorer",
        text_align = "center",
      },
      {
        filetype = "filetree",
        text = "Explorer",
        text_align = "center",
      },
      {
        filetype = "NvimTree",
        text = "Explorer",
        text_align = "center",
      },
    },
  },
})
