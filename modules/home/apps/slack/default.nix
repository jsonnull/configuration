{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.apps.slack;
in
{
  options.apps.slack.enable = lib.mkEnableOption "Enable Slack";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.slack ];
  };
}
