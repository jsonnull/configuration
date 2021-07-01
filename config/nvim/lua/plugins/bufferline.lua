vim.g.bufferline_echo = 0

vim.api.nvim_exec([[
  autocmd VimEnter * let &statusline='%{bufferline#refresh_status()}' .bufferline#get_status_string()
]], false)
