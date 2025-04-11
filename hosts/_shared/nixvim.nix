{ pkgs, ... }:

{
  programs.nixvim = {
    colorschemes.modus = {
      enable = true;
      settings.variant = "deuteranopia";
    };

    # colorscheme-adjacent properties
    opts.background = "light";
    opts.termguicolors = true;

    enable = true;

    autoCmd = [{
      command = "set filetype=jsonc";
      event = [ "BufNewFile" "BufRead" ];
      pattern = [ "tsconfig.json" "devcontainer.json" ];
    }];

    globals = {
      # Disabling netrw, recommended by nvim-tree  
      loaded_netrw = 1;
      loaded_netrwPlugin = 1;

      mapleader = ",";
    };

    keymaps = [
      {
        action = ":NvimTreeToggle<cr>";
        key = "<c-n>";
        mode = "n";
      }
      {
        action = "<cmd>lua Snacks.picker.buffers()<cr>";
        key = "<leader>b";
        mode = "n";
      }
      {
        action = "<cmd>lua Snacks.picker.git_files()<cr>";
        key = "<c-p>";
        mode = "n";
      }
      {
        action = "<cmd>lua Snacks.picker.grep()<cr>";
        key = "<c-e>";
        mode = "n";
      }
      {
        action = "<cmd>Bdelete<cr>";
        key = "<leader>w";
        mode = "n";
      }
      {
        action = "<cmd>Bwipeout<cr>";
        key = "<leader>q";
        mode = "n";
      }
      {
        action = "<cmd>Telescope lsp_workspace_symbols<cr>";
        key = "<c-t>";
        mode = "n";
      }
      {
        action = "yy";
        key = "Y";
        mode = "n";
      }
      {
        action = ":noh<cr>";
        key = "<leader>h";
        mode = "n";
      }
      {
        action = "<C-\\><C-n>";
        key = "<Esc>";
        mode = "t";
      }
      # Nvim Dap
      {
        key = "<leader>du";
        mode = [ "n" ];
        action = "<cmd>lua require('dapui').toggle()<cr>";
        options = { desc = "Dap UI"; };
      }
      {
        key = "<F5>";
        mode = [ "n" ];
        action = "<cmd>lua require('dap').continue()<cr>";
        options = { desc = "Dap continue"; };
      }
      {
        key = "<F10>";
        mode = [ "n" ];
        action = "<cmd>lua require('dap').step_over()<cr>";
        options = { desc = "Dap Step Over"; };
      }
      {
        key = "<F11>";
        mode = [ "n" ];
        action = "<cmd>lua require('dap').step_into()<cr>";
        options = { desc = "Dap Step Into"; };
      }
      {
        key = "<F12>";
        mode = [ "n" ];
        action = "<cmd>lua require('dap').step_out()<cr>";
        options = { desc = "Dap Step Out"; };
      }
      {
        key = "<leader>db";
        mode = [ "n" ];
        action = "<cmd>lua require('dap').toggle_breakpoint()<cr>";
        options = { desc = "Dap Toggle Breakpoint"; };
      }
      {
        key = "<leader>dB";
        mode = [ "n" ];
        action.__raw = ''
          function()
            require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
          end
        '';
        options = { desc = "Dap Conditional Breakpoint"; };
      }
    ];

    nixpkgs.pkgs = pkgs.unstable;

    opts = {
      # systematic
      encoding = "utf-8";
      fileencoding = "utf-8";
      fileencodings = [ "utf-8" ];
      backup = false; # no .bak
      swapfile = false; # no .swap
      undofile = true; # use undo file
      updatetime = 300; # time (in ms) to write to swap file
      timeoutlen = 300; # time (in ms) to write to swap file
      # buffer
      expandtab = true; # expand tab
      tabstop = 4; # tab stop
      softtabstop = 4; # soft tab stop
      autoindent = true; # auto indent for new line
      shiftwidth = 4; # auto indent shift width
      # window
      number = true;
      #relativenumber = true;
      # editing
      whichwrap =
        "b,s,<,>,[,]"; # cursor is able to move from end of line to next line
      backspace = [ "indent" "eol" "start" ]; # backspace behaviors
      list = false; # show tabs with listchars
      ignorecase = false; # search with no ignore case
      hlsearch = true; # highlight search
      incsearch = false; # no incremental search
      inccommand = "nosplit"; # live substitute preview
      completeopt = [ "menu" "menuone" "noselect" ];
      hidden = true;
      cursorline = true; # show cursor line
      ruler = false; # show ruler line
      colorcolumn =
        "120"; # display a color column when line is longer than 120 chars
      signcolumn = "yes"; # show sign column (column of the line number)
      mouse = "nv"; # enable mouse under normal and visual mode
      showmatch = true; # show bracket match
      cmdheight = 1; # height of :command line
      wildmenu = true; # wildmenu, auto complete for commands
      wildmode = [ "longest" "full" ];
      splitright = true; # split to right
      splitbelow = true; # split to below
      clipboard = "unnamedplus"; # share system clipboard
      # tree-sitter code folding
      foldmethod = "expr";
      foldexpr = "nvim_treesitter#foldexpr()";
      foldlevelstart = 99;
    };

    plugins.auto-session = {
      enable = true;
      settings.suppressed_dirs = [ "~/" "~/Programming/" "~/code/" ];
    };

    plugins.bufdelete.enable = true;

    plugins.bufferline = {
      enable = true;
      settings = {
        options = {
          offsets = [
            {
              filetype = "bufferlist";
              text = "Explorer";
              text_align = "center";
            }
            {
              filetype = "filetree";
              text = "Explorer";
              text_align = "center";
            }
            {
              filetype = "NvimTree";
              text = "Explorer";
              text_align = "center";
            }
          ];
        };
      };
    };

    plugins.cmp = {
      autoEnableSources = true;
      enable = true;
      settings = {
        disallow_fuzzy_matching = true;
        disallow_partial_matching = true;
        performance.throttle = 200;
        sources = [
          { name = "async_path"; }
          { name = "git"; }
          { name = "nvim_lsp"; }
          { name = "nvim_lsp_signature_help"; }
          { name = "treesitter"; }
          {
            name = "spell";
          }
          #{ name = "buffer"; }
        ];
        mapping = {
          "<c-space>" = "cmp.mapping.complete()";
          "<c-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<c-n>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<c-e>" = "cmp.mapping.close()";
          /* "<Tab>" = ''
               cmp.mapping(function(fallback)
                 -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
                 if cmp.visible() then
                   local entry = cmp.get_selected_entry()
                   if not entry then
                     cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                   end
                   cmp.confirm()
                 else
                   fallback()
                 end
               end, {"i","s","c",})
             '';
          */
        };
      };
    };

    plugins.comment.enable = true;

    plugins.dap = {
      enable = true;
      extensions = {
        dap-ui.enable = true;
        dap-virtual-text.enable = true;
      };
      adapters = {
        executables.chrome = {
          command = "${pkgs.vscode-js-debug}/bin/js-debug";
        };
        executables.firefox = {
          command = "${pkgs.nodejs}/bin/node";
          args = [
            "${pkgs.vscode-extensions.firefox-devtools.vscode-firefox-debug}/share/vscode/extensions/firefox-devtools.vscode-firefox-debug/dist/adapter.bundle.js"
          ];
        };
      };
      luaConfig.post = ''
        local js_based_languages = { "typescript", "javascript", "typescriptreact" }
        for _, language in ipairs(js_based_languages) do
          require("dap").configurations[language] = {
            --[[
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "''${file}",
              cwd = "''${workspaceFolder}",
            },
            {
             type = 'pwa-node',
             request = 'attach',
             name = 'Attach to Node app',
             address = 'localhost',
             port = 9229,
             cwd = "''${workspaceFolder}",
             restart = true,
            },
            ]]
            {
              name = 'Debug Stories with Firefox',
              type = 'firefox',
              request = 'attach',
              reAttach = true,
              url = 'http://localhost:6006',
              webRoot = "''${workspaceFolder}",
              firefoxExecutable = '${pkgs.firefox}/bin/firefox',
            }
          }
        end

        local dap, dapui = require("dap"), require("dapui")

        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      '';
    };

    plugins.gitsigns.enable = true;

    plugins.illuminate.enable = true;

    plugins.indent-blankline.enable = false;

    plugins.lsp = {
      enable = true;
      inlayHints = true;
      keymaps = {
        lspBuf = {
          "<leader>ld" = "definition";
          "<leader>lD" = "declaration";
          "<leader>lt" = "type_definition";
          "<leader>li" = "implementation";
          "K" = "hover";
          "U" = "signature_help";
          "<leader>lr" = "references";
          "<leader>ls" = "signature_help";
          #"<leader>lS" = "workspace_symbol";
          "<leader>lR" = "rename";
          "<leader>lA" = "code_action";
          "<leader>lf" = "format";
        };
        silent = true;
      };
      servers = {
        bashls.enable = true;
        cssls.enable = true;
        eslint.enable = true;
        html.enable = true;
        jsonls.enable = true;
        lua_ls = {
          enable = true;
          settings.runtime.version = "LuaJIT";
        };
        nixd.enable = true;
        svelte.enable = true;
        #ts_ls.enable = true;
        yamlls.enable = true;
      };
    };

    plugins.lsp-format.enable = true;

    plugins.lspkind.enable = true;

    plugins.lualine = {
      enable = true;
      settings = {
        disabled_filetypes = [ "NvimTree" "startify" ];
        globalstatus = true;
      };
    };

    plugins.nix.enable = true;

    plugins.none-ls = {
      enable = true;
      sources = {
        formatting.stylua.enable = true;
        formatting.nixfmt.enable = true;
        formatting.prettier = {
          enable = true;
          disableTsServerFormatter = true;
        };
        #completion.spell.enable = true;
      };
    };

    plugins.nvim-tree = {
      enable = true;
      filters.custom = [ ".direnv" ".git/" "node_modules" ".cache" ];
      view.width = 40;
      git.ignore = false;
      renderer.groupEmpty = true;
    };

    plugins.snacks = {
      enable = true;
      settings = {
        bigfile.enabled = true;
        quickfile.enable = true;
        statuscolumn.enabled = true;
        words.enabled = true;
      };
    };

    plugins.startify = {
      enable = true;
      settings = {
        change_to_dir = false;
        custom_header = [
          ""
          ""
          "      _                     _ _ "
          "     |_|___ ___ ___ ___ _ _| | |"
          "     | |_ -| . |   |   | | | | |"
          "    _| |___|___|_|_|_|_|___|_|_|"
          "   |___|                        "
          ""
          ""
        ];
        lists = [{ type = "dir"; }];
      };
    };

    plugins.telescope.enable = false;
    /* plugins.telescope = {
         enable = true;
         extensions = {
           ui-select = {
             enable = true;
             settings.specific_opts.codeactions = false;
           };
           fzf-native.enable = true;
         };
         keymaps = {
           "<esc>" = { action = "close"; };
           "<c-p>" = { action = "find_files"; };
           "<c-e>" = { action = "live_grep"; };
         };
       };
    */

    plugins.treesitter = {
      enable = true;

      grammarPackages =
        with pkgs.unstable.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          javascript
          json
          lua
          make
          markdown
          nix
          regex
          svelte
          toml
          tsx
          typescript
          vim
          vimdoc
          xml
          yaml
        ];

      settings = {
        highlight.enable = true;
        incremental_selection.enable = true;
        indent.enable = true;
        # Warning: remove if moving to auto-installed grammars
        parser_install_dir = null;
      };
    };

    plugins.typescript-tools.enable = true;

    plugins.vim-surround.enable = true;

    plugins.web-devicons.enable = true;

    plugins.which-key.enable = true;
  };
}
