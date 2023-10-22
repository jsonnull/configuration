---@diagnostic disable: undefined-global
local cmd = vim.cmd
local opt = vim.opt
local has = vim.fn.has

cmd("filetype plugin indent on")
cmd("syntax enable")

-- systematic
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileencodings = { "utf-8" }
opt.backup = false    -- no .bak
opt.swapfile = false  -- no .swap
opt.undofile = true   -- use undo file
opt.updatetime = 300  -- time (in ms) to write to swap file
opt.timeoutlen = 300  -- time (in ms) to write to swap file
-- buffer
opt.expandtab = true  -- expand tab
opt.tabstop = 4       -- tab stop
opt.softtabstop = 4   -- soft tab stop
opt.autoindent = true -- auto indent for new line
opt.shiftwidth = 4    -- auto indent shift width
-- window
opt.number = true
opt.relativenumber = true
-- editing
opt.whichwrap = "b,s,<,>,[,]"                -- cursor is able to move from end of line to next line
opt.backspace = { "indent", "eol", "start" } -- backspace behaviors
opt.list = false                             -- show tabs with listchars
opt.ignorecase = false                       -- search with no ignore case
opt.hlsearch = true                          -- highlight search
opt.incsearch = false                        -- no incremental search
opt.inccommand = "nosplit"                   -- live substitute preview
opt.completeopt = { "menu", "menuone", "noselect" }
opt.hidden = true
opt.cursorline = true         -- show cursor line
opt.ruler = false             -- show ruler line
opt.colorcolumn = { 120 }     -- display a color column when line is longer than 120 chars
opt.signcolumn = "yes"        -- show sign column (column of the line number)
opt.mouse = "nv"              -- enable mouse under normal and visual mode
cmd("set mousehide")          -- hide mouse when characters are typed
opt.showmatch = true          -- show bracket match
opt.cmdheight = 1             -- height of :command line
opt.wildmenu = true           -- wildmenu, auto complete for commands
opt.wildmode = { "longest", "full" }
opt.splitright = true         -- split to right
opt.splitbelow = true         -- split to below
opt.shortmess:append("c")     -- status line e.g. CTRL+G
opt.clipboard = "unnamedplus" -- share system clipboard
-- tree-sitter code folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevelstart = 99
-- Apparently there's an issue with treesitter folding and telescope:
-- https://github.com/nvim-telescope/telescope.nvim/issues/699
--[[
vim.api.nvim_create_autocmd({ "BufEnter", "BufNew", "BufWinEnter" }, {
    group = vim.api.nvim_create_augroup("ts_fold_workaround", { clear = true }),
    command = "set foldexpr=nvim_treesitter#foldexpr()",
})
]]

-- Disabling netrw, recommended by nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = ","

cmd("let g:copilot_no_tab_map = v:true")
cmd('imap <expr> <Plug>(vimrc:copilot-dummy-map) copilot#Accept("\\<Tab>")')

opt.background = "dark"
-- vim.g.colors_name = 'nullify'

opt.termguicolors = true

-- set some files to JSONC type
cmd("au BufNewFile,BufRead tsconfig.json set filetype=jsonc")
cmd("au BufNewFile,BufRead devcontainer.json set filetype=jsonc")
