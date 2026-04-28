{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.tools.zellij;
in
{
  options.tools.zellij.enable = lib.mkEnableOption "Enable Zellij";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.zellij ];

    xdg.configFile."zellij/config.kdl".source = ./config.kdl;
    xdg.configFile."zellij/themes/oxocarbon.kdl".source = ./themes/oxocarbon.kdl;
  };
}
