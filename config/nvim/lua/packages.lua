return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- theme
  -- use 'shaunsingh/nord.nvim'
  -- use 'projekt0n/github-nvim-theme'
  -- use 'EdenEast/nightfox.nvim'
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    tag = 'v1.*',
    config = function()
      vim.cmd('colorscheme rose-pine')
    end
  })

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
    requires = { 'nvim-lua/plenary.nvim' },
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
          ["ui-select"] = {
              require('telescope.themes').get_dropdown({
                  --
              })
          },
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
  use 'nvim-telescope/telescope-ui-select.nvim' -- use telescope for vim.ui.select
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
        ignore_ft_on_setup = { 'startify' },
        filters = {
          custom = { '.direnv', '.git/', 'node_modules', '.cache', 'build', 'built' },
        },
        view = {
          width = 40,
        },
        git = {
          ignore = false,
        },
      }

      local opts = {
          noremap = true,
          silent = false,
          expr = false,
      }

      vim.api.nvim_set_keymap('n', '<c-n>', ":NvimTreeToggle<cr>", opts)
      vim.api.nvim_set_keymap('n', '<c-l>', ":NvimTreeFindFile<cr>", opts)
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
  use 'Yggdroot/indentLine' -- indent line
  use({
    'nvim-lualine/lualine.nvim',
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
  use 'tpope/vim-surround' -- toggle surround
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
    }

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
    config = function ()
      require('plugins.lsp')()
    end
  }
  use {
    'hrsh7th/nvim-cmp', -- completion
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      { "L3MON4D3/LuaSnip", tag = "v1.*" }, -- snippets
        'saadparwaiz1/cmp_luasnip',
    },
    config = function ()
      local cmp = require'cmp'

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-c>'] = cmp.mapping.close(),
          ['<tab>'] = cmp.mapping.confirm({ select = true }),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<C-g>'] = cmp.mapping(function(fallback)
            vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)), 'n', true)
          end)
        }),
        experimental = {
          ghost_text = false -- this feature conflict with copilot.vim's preview.
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        })
      })

      require("luasnip.loaders.from_snipmate").lazy_load()
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
