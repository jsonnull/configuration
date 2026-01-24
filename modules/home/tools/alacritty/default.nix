{
  lib,
  pkgs,
  config,
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

        font.size = 13;
        font.offset = {
          x = 0;
          y = 1;
        };
        font.normal = {
          family = "IosevkaTerm Nerd Font";
          style = "Regular";
        };

        terminal.shell.program = "/etc/profiles/per-user/json/bin/zsh";

        # Kanso Zen colors
        colors = {
          primary = {
            background = "#090E13";
            foreground = "#C5C9C7";
          };
          selection = {
            background = "#393B44";
            foreground = "#C5C9C7";
          };
          normal = {
            black = "#090E13";
            red = "#c4746e";
            green = "#8a9a7b";
            yellow = "#c4b28a";
            blue = "#8ba4b0";
            magenta = "#a292a3";
            cyan = "#8ea4a2";
            white = "#c8c093";
          };
          bright = {
            black = "#A4A7A4";
            red = "#e46876";
            green = "#87a987";
            yellow = "#e6c384";
            blue = "#7fb4ca";
            magenta = "#938aa9";
            cyan = "#7aa89f";
            white = "#C5C9C7";
          };
        };

        window.padding = {
          x = 8;
          y = 0;
        };

        window.decorations_theme_variant = "Dark";
      };
    };
  };
}
