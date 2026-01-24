{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
let
  cfg = config.tools.nixcats;
in
{
  imports = [ inputs.nixCats.homeModule ];

  options.tools.nixcats.enable = lib.mkEnableOption "Enable nixCats";

  config = lib.mkIf cfg.enable {
    nixCats = {
      enable = true;
      packageNames = [ "ncats" ];
      luaPath = "${./.}";

      categoryDefinitions.replace = { pkgs, ... }: {
        lspsAndRuntimeDeps = {
          general = with pkgs; [
            ripgrep
            fd
          ];
        };

        # Plugins that load immediately at startup
        startupPlugins = {
          general = with pkgs.vimPlugins; [
            # Core dependencies
            plenary-nvim
            nvim-web-devicons

            # Lazy loader
            lze

            # UI (always visible)
            lualine-nvim
            bufferline-nvim

            # Snacks (has startup features)
            snacks-nvim

            # Session management (needs early load)
            auto-session
          ];
        };

        # Plugins that load on-demand
        optionalPlugins = {
          general = with pkgs.vimPlugins; [
            # File explorer
            nvim-tree-lua

            # Pickers
            telescope-nvim
            telescope-fzf-native-nvim

            # Utilities
            which-key-nvim
            bufdelete-nvim
          ];
        };
      };

      packageDefinitions.replace = {
        ncats = { pkgs, ... }: {
          settings = {
            wrapRc = true;
            # No aliases - keeps nvim/vim pointing to nixvim
          };
          categories = {
            general = true;
          };
        };
      };
    };
  };
}
