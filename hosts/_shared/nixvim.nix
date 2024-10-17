{ pkgs, ... }:

{
  programs.nixvim= {
    enable = true;

    keymaps = [
      {
        action = ":NvimTreeToggle<cr>";
        key = "<c-n>";
        mode = "n";
      }
    ];

    plugins.bufferline = {
      enable = true;
      #settings = {
      #  options = {
      #    offsets = [
      #      {
      #        filetype = "bufferlist";
      #        text = "Explorer";
      #        text_align = "center";
      #      }
      #      {
      #        filetype = "filetree";
      #        text = "Explorer";
      #        text_align = "center";
      #      }
      #      {
      #        filetype = "NvimTree";
      #        text = "Explorer";
      #        text_align = "center";
      #      }
      #    ];
      #  };
      #};
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
  };
}

