{
  lib,
  config,
  ...
}:
let
  cfg = config.tools.ghostty;
in
{
  options.tools.ghostty.enable = lib.mkEnableOption "Enable Ghostty";

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        # Shell
        command = "/etc/profiles/per-user/json/bin/zsh";

        # Font
        font-family = "IosevkaTerm Nerd Font";
        font-size = 13;
        adjust-cell-height = "5%";
        adjust-cell-width = "-10%";

        # Window
        window-padding-x = 4;
        window-padding-y = 4;
        window-theme = "ghostty";
        window-show-tab-bar = "never";

        # Oxocarbon colors
        background = "#161616";
        foreground = "#f2f4f8";
        cursor-color = "#f2f4f8";
        selection-background = "#393939";
        selection-foreground = "#f2f4f8";

        palette = [
          "0=#161616"
          "1=#ee5396"
          "2=#42be65"
          "3=#ff7eb6"
          "4=#78a9ff"
          "5=#be95ff"
          "6=#3ddbd9"
          "7=#dde1e6"
          "8=#525252"
          "9=#ee5396"
          "10=#42be65"
          "11=#ff7eb6"
          "12=#78a9ff"
          "13=#be95ff"
          "14=#3ddbd9"
          "15=#f2f4f8"
        ];
      };
    };
  };
}
