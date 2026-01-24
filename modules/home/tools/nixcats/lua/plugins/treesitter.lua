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

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = { query = "@function.outer", desc = "Select outer function" },
        ["if"] = { query = "@function.inner", desc = "Select inner function" },
        ["ac"] = { query = "@class.outer", desc = "Select outer class" },
        ["ic"] = { query = "@class.inner", desc = "Select inner class" },
        ["aa"] = { query = "@parameter.outer", desc = "Select outer argument" },
        ["ia"] = { query = "@parameter.inner", desc = "Select inner argument" },
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]f"] = { query = "@function.outer", desc = "Next function start" },
        ["]c"] = { query = "@class.outer", desc = "Next class start" },
        ["]a"] = { query = "@parameter.inner", desc = "Next argument" },
      },
      goto_next_end = {
        ["]F"] = { query = "@function.outer", desc = "Next function end" },
        ["]C"] = { query = "@class.outer", desc = "Next class end" },
      },
      goto_previous_start = {
        ["[f"] = { query = "@function.outer", desc = "Previous function start" },
        ["[c"] = { query = "@class.outer", desc = "Previous class start" },
        ["[a"] = { query = "@parameter.inner", desc = "Previous argument" },
      },
      goto_previous_end = {
        ["[F"] = { query = "@function.outer", desc = "Previous function end" },
        ["[C"] = { query = "@class.outer", desc = "Previous class end" },
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>sa"] = { query = "@parameter.inner", desc = "Swap with next argument" },
      },
      swap_previous = {
        ["<leader>sA"] = { query = "@parameter.inner", desc = "Swap with previous argument" },
      },
    },
  },
})
