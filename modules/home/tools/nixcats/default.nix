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
          general = with pkgs; [ ripgrep fd ];
        };
        startupPlugins = {
          general = with pkgs.vimPlugins; [
            plenary-nvim
            which-key-nvim
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
