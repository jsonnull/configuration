-- Treesitter configuration (startup plugin)
-- Grammars are provided by Nix via nvim-treesitter.withPlugins
-- The new nvim-treesitter no longer has a configs module;
-- highlight/indent are enabled automatically when parsers are available.

-- Jess language: register custom tree-sitter parser
-- nvim/parser/jess.so has the compiled grammar, nvim/queries/jess/ has highlights
vim.opt.runtimepath:append(vim.fn.expand("~/code/jess-lang/nvim"))
vim.treesitter.language.register("jess", "jess")
vim.api.nvim_create_autocmd("FileType", {
  pattern = "jess",
  callback = function()
    vim.treesitter.start()
  end,
})

-- Textobjects setup (lookahead for select)
require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
  },
  move = {
    set_jumps = true,
  },
})

-- Textobject select keymaps
local select = require("nvim-treesitter-textobjects.select")
local select_maps = {
  ["af"] = { "@function.outer", "Select outer function" },
  ["if"] = { "@function.inner", "Select inner function" },
  ["ac"] = { "@class.outer", "Select outer class" },
  ["ic"] = { "@class.inner", "Select inner class" },
  ["aa"] = { "@parameter.outer", "Select outer argument" },
  ["ia"] = { "@parameter.inner", "Select inner argument" },
}
for key, val in pairs(select_maps) do
  vim.keymap.set({ "x", "o" }, key, function()
    select.select_textobject(val[1])
  end, { desc = val[2] })
end

-- Textobject move keymaps
local move = require("nvim-treesitter-textobjects.move")
local move_maps = {
  -- goto_next_start
  ["]f"] = { move.goto_next_start, "@function.outer", "Next function start" },
  ["]c"] = { move.goto_next_start, "@class.outer", "Next class start" },
  ["]a"] = { move.goto_next_start, "@parameter.inner", "Next argument" },
  -- goto_next_end
  ["]F"] = { move.goto_next_end, "@function.outer", "Next function end" },
  ["]C"] = { move.goto_next_end, "@class.outer", "Next class end" },
  -- goto_previous_start
  ["[f"] = { move.goto_previous_start, "@function.outer", "Previous function start" },
  ["[c"] = { move.goto_previous_start, "@class.outer", "Previous class start" },
  ["[a"] = { move.goto_previous_start, "@parameter.inner", "Previous argument" },
  -- goto_previous_end
  ["[F"] = { move.goto_previous_end, "@function.outer", "Previous function end" },
  ["[C"] = { move.goto_previous_end, "@class.outer", "Previous class end" },
}
for key, val in pairs(move_maps) do
  vim.keymap.set({ "n", "x", "o" }, key, function()
    val[1](val[2])
  end, { desc = val[3] })
end

-- Textobject swap keymaps
local swap = require("nvim-treesitter-textobjects.swap")
vim.keymap.set("n", "<leader>sa", function()
  swap.swap_next("@parameter.inner")
end, { desc = "Swap with next argument" })
vim.keymap.set("n", "<leader>sA", function()
  swap.swap_previous("@parameter.inner")
end, { desc = "Swap with previous argument" })
