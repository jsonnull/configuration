-- LSP configuration (lazy-loaded)

-- Helper: on_attach function for keymaps and settings
local function on_attach(client, bufnr)
  local opts = { buffer = bufnr, silent = true }

  -- Navigation
  vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
  vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
  vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
  vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Find references" }))

  -- Information
  vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
  vim.keymap.set("n", "U", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))

  -- Actions
  vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
  vim.keymap.set("n", "<leader>lA", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))

  -- Note: <leader>lf format keymap intentionally omitted - conform will handle formatting

  -- Enable inlay hints if supported
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

-- Set up LspAttach autocommand for keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      on_attach(client, args.buf)
    end
  end,
})

-- LSP server configurations using vim.lsp.config (Neovim 0.11+)
vim.lsp.config.bashls = {}

vim.lsp.config.cssls = {}

vim.lsp.config.eslint = {}

vim.lsp.config.html = {}

vim.lsp.config.jsonls = {}

vim.lsp.config.lua_ls = {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim", "nixCats", "Snacks" },
      },
      workspace = {
        checkThirdParty = false,
        ignoreDir = {
          ".direnv",
          ".git",
          "result",
          "node_modules",
        },
      },
    },
  },
}

vim.lsp.config.nil_ls = {
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixfmt" },
      },
    },
  },
}

vim.lsp.config.svelte = {}

vim.lsp.config.yamlls = {}

vim.lsp.config.rust_analyzer = {}

-- Enable all configured LSP servers
vim.lsp.enable({
  "bashls",
  "cssls",
  "eslint",
  "html",
  "jsonls",
  "lua_ls",
  "nil_ls",
  "svelte",
  "yamlls",
  "rust_analyzer",
})

-- Load typescript-tools lazily on TypeScript/JavaScript files
require("lze").load({
  {
    "typescript-tools.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    after = function()
      require("typescript-tools").setup({
        on_attach = on_attach,
        settings = {
          separate_diagnostic_server = true,
          publish_diagnostic_on = "insert_leave",
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
          },
        },
      })
    end,
  },
})
