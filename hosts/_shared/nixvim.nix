{ pkgs, ... }:

{
  programs.nixvim= {
    colorschemes.kanagawa.enable = true;
    #colorschemes.everforest = {
    #  enable = true;
    #  settings.background = "hard";
    #};

    enable = true;

    keymaps = [
      {
        action = ":NvimTreeToggle<cr>";
        key = "<c-n>";
        mode = "n";
      }
    ];

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
      settings.sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
        { name = "nvim_lsp_signature_help"; }
      ];
    };

    plugins.comment.enable = true;

    plugins.lualine = {
      enable = true;
      settings = {
        disabled_filetypes = [ "NvimTree" "startify" ];
        globalstatus = true;
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
        lists = [
          {
            type = "dir";
          }
        ];
      };
    };

    plugins.telescope = {
      enable = true;
      extensions = {
        ui-select.enable = true;
        fzf-native.enable = true;
      };
      keymaps = {
        "<esc>" = {
          action = "close";
        };
        "<c-p>" = {
          action = "find_files";
        };
        "<c-e>" = {
          action = "live_grep";
        };
      };
    };

    plugins.treesitter = {
      enable = true;

      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        json
        lua
        make
        markdown
        nix
        regex
        toml
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

    plugins.web-devicons.enable = true;

    plugins.which-key.enable = true;
  };
}

