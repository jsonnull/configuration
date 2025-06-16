{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.apps.chrome;
in
{
  options.apps.chrome.enable = lib.mkEnableOption "Enable Ungoogled Chromium";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.ungoogled-chromium ];
  };
}
