{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.tools.gamedev;
in
{
  options.tools.gamedev.enable = lib.mkEnableOption "Enable game development tools";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      blender
    ];
  };
}
