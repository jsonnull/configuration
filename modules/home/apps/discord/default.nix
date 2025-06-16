{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.apps.discord;
in
{
  options.apps.discord.enable = lib.mkEnableOption "Enable Discord";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.discord ];
  };
}
