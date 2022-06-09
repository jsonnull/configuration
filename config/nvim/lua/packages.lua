return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- lib
  --use 'nvim-lua/popup.nvim'

  -- theme
  -- use 'shaunsingh/nord.nvim'
  -- use 'projekt0n/github-nvim-theme'
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    tag = 'v1.*',
    config = function()
      vim.cmd('colorscheme rose-pine')
    end
  })
  -- use 'EdenEast/nightfox.nvim'

  -- file
  use {
    'mhinz/vim-startify', -- startup page
    config = function()
      vim.g.startify_custom_header = {
      '',
      '',
      '      _                     _ _ ',
      '     |_|___ ___ ___ ___ _ _| | |',
      '     | |_ -| . |   |   | | | | |',
      '    _| |___|___|_|_|_|_|___|_|_|',
      '   |___|                        ',
      '',
      '',
      }

      vim.g.startify_lists = {
        { type = 'dir' }
      }

      vim.g.startify_change_to_dir = 0
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      local opts = {
          noremap = true,
          silent = false,
          expr = false,
      }

      vim.api.nvim_set_keymap('n', '<c-p>', "<cmd>Telescope find_files<cr>", opts)
      vim.api.nvim_set_keymap('n', '<c-e>', "<cmd>Telescope live_grep<cr>", opts)

      local actions = require('telescope.actions')
      require('telescope').setup({
          defaults = {
              mappings = {
                  i = {
                      ['<esc>'] = actions.close,
                  },
              },
          },
      })
    end
  }
  use 'crispgm/telescope-heading.nvim' -- markdown heading
  use {
    'rmagatti/session-lens',
    requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
    config = function()
      require('session-lens').setup {
        log_level = 'info',
        auto_session_suppress_dirs = {'~/', '~/Programming'}
      }
    end
  }
  use 'famiu/bufdelete.nvim' -- better buffer removal

  -- IDE
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function()
      require'nvim-tree'.setup {
        open_on_setup = true,
        disable_window_picker = true,
        ignore_ft_on_setup = { 'startify' },
        filters = {
          custom = { '.git', 'node_modules', '.cache', 'build', 'built' },
        },
        view = {
          width = 40,
        },
      }

      local opts = {
          noremap = true,
          silent = false,
          expr = false,
      }

      vim.api.nvim_set_keymap('n', '<c-n>', ":NvimTreeToggle<cr>", opts)
    end
  }
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  }
  use 'dstein64/nvim-scrollview' -- scroll bar
  use 'google/vim-searchindex' -- search index
  -- use 'editorconfig/editorconfig-vim' -- editorconfig support
  use 'Yggdroot/indentLine' -- indent line
  use({
    'nvim-lualine/lualine.nvim',
    -- fix mismatch palette between variants
    -- event = 'ColorScheme',
    config = function()
      require('lualine').setup({
        options = {
          ---@usage 'rose-pine' | 'rose-pine-alt'
          theme = 'auto', -- 'rose-pine',
          disabled_filetypes = { 'NvimTree', 'startify' }
        }
      })
    end
  })
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    -- tag = 'release' -- To use the latest release
  }
  --[[ ADD THESE BACK IN
  use 'f-person/git-blame.nvim' -- toggle git blame info
  use 'rhysd/conflict-marker.vim' -- git conflict
  use 'norcalli/nvim-colorizer.lua' -- color codes rendering
  use 'tversteeg/registers.nvim' -- show registers
  use 'winston0410/cmd-parser.nvim' -- dependency of range-highlight
  use 'winston0410/range-highlight.nvim' -- highlight range lines
  ]]
  -- use 'simrat39/symbols-outline.nvim' -- symbols outline

  --[[
  use {
    'folke/trouble.nvim', -- LSP error list
    config = function()
      require("trouble").setup {
        auto_open = true,
        auto_close = true,
        -- Workaround for `invalid buffer id` error
        -- @see https://github.com/folke/trouble.nvim/issues/125
        auto_preview = false,
      }
    end
  }
  ]]

  -- edit
  --[[ ADD THESE BACK IN
  use 'tpope/vim-surround' -- toggle surround
  use 'tpope/vim-commentary' -- toggle comment
  {
      'prettier/vim-prettier', -- prettier formatter
      run = 'yarn install',
      branch = 'release/0.x',
  }
  ]]

  -- language
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- treesitter
  use 'nvim-treesitter/playground' -- treesitter playground
  use {
    'nvim-treesitter/nvim-treesitter-textobjects', -- treesitter textobj e.g., class, function
    config = function()
      require'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      }
    end
  }
  use {
    'neovim/nvim-lspconfig', -- lsp client config
    requires = { "RRethy/vim-illuminate" }, -- highlight hover word }
    config = function()
      require('plugins.lsp')()
    end,
  }
  use {
    'hrsh7th/nvim-compe', -- completion
    config = function()
      require('compe').setup({
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = 'enable',
        throttle_time = 80,
        source_timeout = 200,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        documentation = true,

        source = {
          path = true,
          buffer = true,
          calc = true,
          vsnip = false,
          nvim_lsp = true,
          nvim_lua = true,
          spell = true,
          tags = true,
          snippets_nvim = false,
          treesitter = true,
        },
      })

      local vim = vim
      local opts = {
          noremap = true,
          silent = true,
          expr = true,
      }

      vim.api.nvim_set_keymap('i', '<c-space>', "compe#complete()", opts)
      vim.api.nvim_set_keymap('i', '<cr>', "compe#confirm('<CR>')", opts)
      vim.api.nvim_set_keymap('i', '<c-c>', "compe#close('<c-c>')", opts)
      -- Make <tab> auto-select the first entry
      vim.api.nvim_set_keymap("i", "<tab>", "compe#confirm({ 'keys': '<tab>', 'select': v:true })", { expr = true })
    end
  }
  use 'rust-lang/rust.vim' -- rust language support
  use 'LnL7/vim-nix' -- nix language support

  use 'github/copilot.vim'

  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function ()
      require"octo".setup()
    end
  }
end)
