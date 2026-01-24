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
        font-size = 12;

        # Window
        window-padding-x = 8;
        window-padding-y = 0;
        window-theme = "ghostty";
        window-show-tab-bar = "never";

        # Kanso Zen colors (recommended settings)
        background = "#090E13";
        foreground = "#c5c9c7";
        cursor-color = "#c5c9c7";
        selection-background = "#22262D";
        selection-foreground = "#c5c9c7";

        palette = [
          "0=#090E13"
          "1=#c4746e"
          "2=#8a9a7b"
          "3=#c4b28a"
          "4=#8ba4b0"
          "5=#a292a3"
          "6=#8ea4a2"
          "7=#a4a7a4"
          "8=#5C6066"
          "9=#e46876"
          "10=#87a987"
          "11=#e6c384"
          "12=#7fb4ca"
          "13=#938aa9"
          "14=#7aa89f"
          "15=#c5c9c7"
        ];
      };
    };
  };
}
