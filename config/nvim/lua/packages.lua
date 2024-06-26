return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- theme
    -- use 'shaunsingh/nord.nvim'
    -- use 'projekt0n/github-nvim-theme'
    -- use 'EdenEast/nightfox.nvim'
    use({
        --[[
		"rose-pine/neovim",
		as = "rose-pine",
		tag = "v1.*",
        ]]
        -- "bluz71/vim-nightfly-colors",
        -- "rebelot/kanagawa.nvim",
        -- "sainnhe/everforest",
        -- "sainnhe/sonokai",
        -- "nyoom-engineering/oxocarbon.nvim",
        --[[
        "~/.config/nvim/nullify-colorscheme",
        requires = { "rktjmp/lush.nvim" },
        ]]
        -- "joshdick/onedark.vim",
        -- "cseelus/vim-colors-lucid",
        'kepano/flexoki-neovim',
        as = 'flexoki',
        config = function()
            -- vim.cmd("colorscheme nullify")
            -- vim.cmd("colorscheme rose-pine")
            -- vim.cmd("colorscheme nightfly")
            -- vim.cmd("colorscheme kanagawa-dragon")
            -- vim.g.everforest_background = "medium"
            -- vim.cmd("colorscheme everforest")
            -- vim.cmd("colorscheme sonokai")
            -- vim.cmd("colorscheme oxocarbon")
            -- vim.cmd("colorscheme onedark")
            vim.cmd("colorscheme flexoki-dark")
        end,
    })

    -- file
    use({
        "mhinz/vim-startify", -- startup page
        config = function()
            vim.g.startify_custom_header = {
                "",
                "",
                "      _                     _ _ ",
                "     |_|___ ___ ___ ___ _ _| | |",
                "     | |_ -| . |   |   | | | | |",
                "    _| |___|___|_|_|_|_|___|_|_|",
                "   |___|                        ",
                "",
                "",
            }

            vim.g.startify_lists = {
                { type = "dir" },
            }

            vim.g.startify_change_to_dir = 0
        end,
    })
    use({
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            local opts = {
                noremap = true,
                silent = false,
                expr = false,
            }

            vim.api.nvim_set_keymap("n", "<c-p>", "<cmd>Telescope find_files<cr>", opts)
            vim.api.nvim_set_keymap("n", "<c-e>", "<cmd>Telescope live_grep<cr>", opts)

            local actions = require("telescope.actions")
            require("telescope").setup({
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({
                        --
                    }),
                },
                defaults = {
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                        },
                    },
                },
            })
        end,
    })
    use("crispgm/telescope-heading.nvim")          -- markdown heading
    use("nvim-telescope/telescope-ui-select.nvim") -- use telescope for vim.ui.select
    use({
        "rmagatti/session-lens",
        requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
        config = function()
            require("session-lens").setup({
                log_level = "info",
                auto_session_suppress_dirs = { "~/", "~/Programming" },
            })
        end,
    })
    use("famiu/bufdelete.nvim") -- better buffer removal

    -- IDE
    use({
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icon
        },
        config = function()
            require("nvim-tree").setup({
                filters = {
                    custom = { ".direnv", ".git/", "node_modules", ".cache" },
                },
                view = {
                    width = 40,
                },
                git = {
                    ignore = false,
                },
                renderer = {
                    group_empty = true,
                },
            })

            local opts = {
                noremap = true,
                silent = false,
                expr = false,
            }

            vim.api.nvim_set_keymap("n", "<c-n>", ":NvimTreeToggle<cr>", opts)
            vim.api.nvim_set_keymap("n", "<c-l>", ":NvimTreeFindFile<cr>", opts)
        end,
    })
    use({
        'akinsho/bufferline.nvim',
        tag = "*",
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup {
                options = {
                    mode = "buffers",
                    numbers = "none",
                    close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
                    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
                    offsets = {
                        { filetype = "bufferlist", text = "Explorer", text_align = "center" },
                        { filetype = "filetree",   text = "Explorer", text_align = "center" },
                        { filetype = "NvimTree",   text = "Explorer", text_align = "center" },
                    },
                    always_show_bufferline = true,
                    sort_by = "id",
                },
            }
        end
    })
    --[[
    use({
        "romgrk/barbar.nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
    })
    ]]
    use({
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({})
        end,
    })
    use("dstein64/nvim-scrollview") -- scroll bar
    use("google/vim-searchindex")   -- search index
    use("Yggdroot/indentLine")      -- indent line
    use({
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup({
                options = {
                    ---@usage 'rose-pine' | 'rose-pine-alt'
                    theme = "auto", -- 'rose-pine',
                    disabled_filetypes = { "NvimTree", "startify" },
                    globalstatus = true,
                },
            })
        end,
    })
    use({
        "lewis6991/gitsigns.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })
    use { 'akinsho/git-conflict.nvim', tag = "*", config = function()
        require('git-conflict').setup({})
    end }

    --[[ ADD THESE BACK IN
    use 'f-person/git-blame.nvim' -- toggle git blame info
    use 'rhysd/conflict-marker.vim' -- git conflict
    use 'norcalli/nvim-colorizer.lua' -- color codes rendering
    use 'tversteeg/registers.nvim' -- show registers
    use 'winston0410/cmd-parser.nvim' -- dependency of range-highlight
    use 'winston0410/range-highlight.nvim' -- highlight range lines
    ]]
    use {
        'simrat39/symbols-outline.nvim',
        config = function()
            require("symbols-outline").setup()
        end
    }

    use {
        'folke/trouble.nvim', -- LSP error list
        config = function()
            require("trouble").setup {
                auto_open = false,
                auto_close = true,
                auto_preview = false,
            }
        end
    }

    -- edit
    use("tpope/vim-surround") -- toggle surround
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })

    -- language
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- treesitter
    use("nvim-treesitter/playground")                             -- treesitter playground
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",            -- treesitter textobj e.g., class, function
        config = function()
            require("nvim-treesitter.configs").setup({
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
            })
        end,
    })
    use({
        "neovim/nvim-lspconfig",                -- lsp client config
        requires = { "RRethy/vim-illuminate" }, -- highlight hover word }
        config = function()
            require("plugins.lsp")()
        end,
    })
    use("lukas-reineke/lsp-format.nvim") -- format on save
    use({
        "hrsh7th/nvim-cmp",              -- completion
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            { "L3MON4D3/LuaSnip", tag = "v1.*" }, -- snippets
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-c>"] = cmp.mapping.close(),
                    ["<tab>"] = cmp.mapping.confirm({ select = true }),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<C-g>"] = cmp.mapping(function()
                        vim.api.nvim_feedkeys(
                            vim.fn["copilot#Accept"](vim.api.nvim_replace_termcodes("<Tab>", true, true, true)),
                            "n",
                            true
                        )
                    end),
                }),
                experimental = {
                    ghost_text = false, -- this feature conflict with copilot.vim's preview.
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                }),
            })

            require("luasnip.loaders.from_snipmate").lazy_load()
        end,
    })
    use({
        "nvimtools/none-ls.nvim",
        config = function()
            require("null-ls").setup()
            require("plugins.lsp")()
        end,
        requires = { "nvim-lua/plenary.nvim" },
    })
    use("rust-lang/rust.vim")  -- rust language support
    use("LnL7/vim-nix")        -- nix language support
    use("ckipp01/stylua-nvim") -- stylua formatter

    use("github/copilot.vim")

    use({
        "pwntester/octo.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "kyazdani42/nvim-web-devicons",
        },
        config = function()
            require("octo").setup()
        end,
    })
end)
