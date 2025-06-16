{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.tools.obsidian;
in
{
  options.tools.obsidian.enable = lib.mkEnableOption "Enable Obsidian";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.obsidian ];
  };
}
