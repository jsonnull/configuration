-- Treesitter configuration (startup plugin)
-- Grammars are provided by Nix via nvim-treesitter.withPlugins

require("nvim-treesitter.configs").setup({
  -- Don't install parsers (Nix handles this)
  auto_install = false,
  ensure_installed = {},

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  indent = {
    enable = true,
  },
})
