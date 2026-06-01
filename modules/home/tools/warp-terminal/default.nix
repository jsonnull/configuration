{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.tools.warp-terminal;
in
{
  options.tools.warp-terminal = {
    enable = lib.mkEnableOption "Enable Warp Terminal";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.warp-terminal ];
  };
}
