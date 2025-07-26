{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.tools.zed;
in
{
  options.tools.zed.enable = lib.mkEnableOption "Enable Zed Editor";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.zed-editor ];
  };
}
