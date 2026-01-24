-- blink.cmp configuration (lazy-loaded)
require("lze").load({
  {
    "blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    after = function()
      require("blink.cmp").setup({
        keymap = {
          preset = "default",
          -- default keymaps:
          -- <C-space> show completion
          -- <C-e> hide completion
          -- <C-y> accept completion
          -- <C-p>/<C-n> or <Up>/<Down> navigate items
          -- <C-b>/<C-f> scroll docs
        },

        appearance = {
          -- Use nerd font icons
          use_nvim_cmp_as_default = true,
          nerd_font_variant = "mono",
        },

        completion = {
          -- Show documentation popup automatically
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
          },

          -- Don't auto-select first item
          list = {
            selection = {
              preselect = false,
              auto_insert = true,
            },
          },

          -- Menu appearance
          menu = {
            border = "rounded",
            draw = {
              columns = {
                { "kind_icon" },
                { "label", "label_description", gap = 1 },
                { "kind", "source_name", gap = 1 },
              },
            },
          },
        },

        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },

        signature = {
          enabled = true,
        },
      })
    end,
  },
})
