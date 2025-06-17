{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.tools.dev-general;
in
{
  options.tools.dev-general.enable = lib.mkEnableOption "Enable general development tools";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      jira-cli-go
    ];
  };
}
