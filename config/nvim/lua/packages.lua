local vim = vim

vim.cmd('packadd paq-nvim')
local paq = require('paq-nvim').paq
paq({ 'savq/paq-nvim', opt = true })

-- lib
paq('nvim-lua/plenary.nvim')
paq('nvim-lua/popup.nvim')

-- theme
paq('shaunsingh/nord.nvim')

-- file
paq('mhinz/vim-startify') -- startup page
paq('nvim-telescope/telescope.nvim') -- fuzzy picker
paq('crispgm/telescope-heading.nvim') -- markdown heading
paq('rmagatti/auto-session') -- auto session
paq('rmagatti/session-lens') -- session lens for telescope

-- view
paq('preservim/nerdtree') -- file tree
paq('ryanoasis/vim-devicons') -- file tree icons
paq('folke/which-key.nvim') -- visual keyboard shortcuts
paq('bling/vim-bufferline') -- show open buffers
paq('dstein64/nvim-scrollview') -- scroll bar
paq('google/vim-searchindex') -- search index
paq('editorconfig/editorconfig-vim') -- editorconfig support
paq('Yggdroot/indentLine') -- indent line
paq('RRethy/vim-illuminate') -- highlight hover word
paq('lewis6991/gitsigns.nvim') -- git signs
paq('f-person/git-blame.nvim') -- toggle git blame info
paq('rhysd/conflict-marker.vim') -- git conflict
paq('norcalli/nvim-colorizer.lua') -- color codes rendering
paq('tversteeg/registers.nvim') -- show registers
paq('winston0410/cmd-parser.nvim') -- dependency of range-highlight
paq('winston0410/range-highlight.nvim') -- highlight range lines

-- edit
paq('tpope/vim-surround') -- toggle surround
paq('tpope/vim-commentary') -- toggle comment
paq({
    'prettier/vim-prettier', -- prettier formatter
    run = 'yarn install',
    branch = 'release/0.x',
})

-- language
paq({
    'nvim-treesitter/nvim-treesitter', -- treesitter
    run = ':TSUpdate',
})
paq('nvim-treesitter/playground') -- treesitter playground
paq('nvim-treesitter/nvim-treesitter-textobjects') -- treesitter textobj e.g., class, function
paq('neovim/nvim-lspconfig') -- lsp client config
paq('hrsh7th/nvim-compe') -- completion
paq('rust-lang/rust.vim') -- rust lang support
