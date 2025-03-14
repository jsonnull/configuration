{ pkgs, ... }:

{
  programs.nixvim = {
    #colorschemes.kanagawa.enable = true;
    colorschemes.ayu.enable = true;

    # colorscheme-adjacent properties
    opts.background = "dark";
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
        action = "<cmd>Telescope buffers<cr>";
        key = "<leader>b";
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
          "<Tab>" = ''
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
        };
      };
    };

    plugins.comment.enable = true;

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

    plugins.telescope = {
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
