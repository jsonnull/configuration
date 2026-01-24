-- nixCats init.lua
-- Migrated from nixvim configuration

--------------------------------------------------------------------------------
-- Globals
--------------------------------------------------------------------------------
vim.g.mapleader = ","
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--------------------------------------------------------------------------------
-- Options
--------------------------------------------------------------------------------

-- Encoding
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = { "utf-8" }

-- File Management
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.timeoutlen = 300

-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true

-- Line Numbers
vim.opt.number = true

-- Navigation
vim.opt.whichwrap = "b,s,<,>,[,]"
vim.opt.backspace = { "indent", "eol", "start" }

-- Search
vim.opt.ignorecase = false
vim.opt.hlsearch = true
vim.opt.incsearch = false
vim.opt.inccommand = "nosplit"

-- Completion
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.hidden = true

-- UI Elements
vim.opt.cursorline = true
vim.opt.ruler = false
vim.opt.colorcolumn = "120"
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

-- Mouse & Interaction
vim.opt.mouse = "nv"
vim.opt.showmatch = true
vim.opt.cmdheight = 1
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest", "full" }

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Folding (treesitter-based)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99

-- Background (default to dark, can be overridden)
vim.opt.background = "dark"

--------------------------------------------------------------------------------
-- Keymaps (non-plugin)
--------------------------------------------------------------------------------

-- Yank entire line with Y
vim.keymap.set("n", "Y", "yy", { desc = "Yank line" })

-- Clear search highlight
vim.keymap.set("n", "<leader>h", ":noh<cr>", { silent = true, desc = "Clear search highlight" })

-- Terminal mode escape
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--------------------------------------------------------------------------------
-- Autocommands
--------------------------------------------------------------------------------

-- Treat tsconfig.json and devcontainer.json as jsonc
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "tsconfig.json", "devcontainer.json" },
  callback = function()
    vim.bo.filetype = "jsonc"
  end,
})

--------------------------------------------------------------------------------
-- Plugin configurations
--------------------------------------------------------------------------------

-- Startup plugins (loaded immediately)
require("plugins.lualine")
require("plugins.bufferline")
require("plugins.startify")
require("plugins.gitsigns")
require("plugins.snacks")
require("plugins.auto-session")

-- Lazy-loaded plugins (via lze)
require("plugins.nvim-tree")
require("plugins.which-key")
require("plugins.bufdelete")

--------------------------------------------------------------------------------
-- nixCats integration
--------------------------------------------------------------------------------
if nixCats then
  vim.notify("nixCats loaded successfully!", vim.log.levels.INFO)
end
