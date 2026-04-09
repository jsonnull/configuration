{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.apps.keepassxc;
in
{
  options.apps.keepassxc.enable = lib.mkEnableOption "Enable KeePassXC";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.keepassxc ];
  };
}
