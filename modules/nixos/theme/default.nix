{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.theme;
in
{
  options.theme = {
    enable = mkEnableOption "theme configuration";

    theme = mkOption {
      type = types.enum [
        "default-light"
        "default-dark"
      ];
      default = "default-dark";
      description = "The theme to use for the system";
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.json = {
      homeTheme.theme = cfg.theme;

      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = if cfg.theme == "default-dark" then "prefer-dark" else "prefer-light";
        };
      };
    };
  };
}
