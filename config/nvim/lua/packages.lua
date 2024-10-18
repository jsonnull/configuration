return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- IDE
    use("google/vim-searchindex")   -- search index
    use("Yggdroot/indentLine")      -- indent line
    use({
        "lewis6991/gitsigns.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })

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
end)
