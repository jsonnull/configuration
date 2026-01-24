-- nixCats POC init.lua
vim.g.mapleader = ","

vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

if nixCats then
  vim.notify("nixCats loaded successfully!", vim.log.levels.INFO)
end
