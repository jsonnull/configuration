{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:
let
  cfg = config.tools.alacritty;
in
{
  options.tools.alacritty.enable = lib.mkEnableOption "Enable Alacritty";

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;

      settings = {
        env.TERM = "xterm-256color";

        font.size = 12;
        font.offset = {
          x = 0;
          y = 2;
        };
        font.normal = {
          family = "IosevkaTerm Nerd Font";
          style = "Regular";
        };

        general.import =
          if osConfig.theme.theme == "default-dark" then
            [ pkgs.alacritty-theme.github_dark_colorblind ]
          else
            [ pkgs.alacritty-theme.github_light_colorblind ];

        terminal.shell.program = "/etc/profiles/per-user/json/bin/zsh";

        colors.primary.background = "#111111";

        window.padding = {
          x = 8;
          y = 0;
        };

        window.decorations_theme_variant =
          if osConfig.theme.theme == "default-dark" then "Dark" else "Light";
      };
    };
  };
}
