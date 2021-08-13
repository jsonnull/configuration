-- vim-bufferline
-----------------

-- vim.g.bufferline_echo = 0

-- vim.api.nvim_exec([[
--  autocmd VimEnter * let &statusline='%{bufferline#refresh_status()}' .bufferline#get_status_string()
--]], false)

-- nvim-bufferline.lua
----------------------

local cmd = vim.cmd
local nord = require('nord.colors')

--local function bg(group, bgcol)
--    cmd("hi " .. group .. " guibg=" .. bgcol)
--end
--local function fg_bg(group, fgcol, bgcol)
--    cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
--end

require("bufferline").setup {
  options = {
    numbers = "buffer_id",
    offsets = {{filetype = "NvimTree", text = "", padding = 1}},
    --buffer_close_icon = "",
    --modified_icon = "",
    --close_icon = "",
    --left_trunc_marker = "",
    --right_trunc_marker = "",
    --max_name_length = 14,
    --max_prefix_length = 13,
    tab_size = 22,
    show_tab_indicators = true,
    enforce_regular_tabs = false,
    view = "multiwindow",
    --show_buffer_close_icons = true,
    separator_style = "thick",
    --mappings = "true"
  }
}

-- bufferline

--fg_bg("BufferLineFill", nord.comments, nord.bg)
--fg_bg("BufferLineBackground", nord.comments, nord.bg)

--fg_bg("BufferLineBufferVisible", nord.comments, nord.bg)
--fg_bg("BufferLineBufferSelected", nord.comments, nord.bg)

--cmd "hi BufferLineBufferSelected gui=bold"

-- tabs
--fg_bg("BufferLineTab", nord.comments, nord.bg)
--fg_bg("BufferLineTabSelected", nord.fg, nord.contrast)
--fg_bg("BufferLineTabClose", nord.fg, nord.bg)

----fg_bg("BufferLineIndicator", black2, black2)
----fg_bg("BufferLineIndicatorSelected", black, black)

--fg_bg("BufferLineSeparator", nord.bg, nord.bg)
--fg_bg("BufferLineSeparatorVisible", nord.bg, nord.bg)
--fg_bg("BufferLineSeparatorSelected", nord.nord9_gui, nord.bg)

