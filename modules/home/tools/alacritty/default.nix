{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:
let
  cfg = config.tools.alacritty;
  
  lightColors = {
    primary = {
      background = "#ffffff";
      foreground = "#000000";
    };

    cursor = {
      text = "#ffffff";
      cursor = "#000000";
    };

    vi_mode_cursor = {
      text = "#ffffff";
      cursor = "#005e8b";
    };

    search = {
      matches = {
        foreground = "#000000";
        background = "#f2f2f2";
      };
      focused_match = {
        foreground = "#000000";
        background = "#008899";
      };
    };

    footer_bar = {
      foreground = "#000000";
      background = "#f2f2f2";
    };

    hints = {
      start = {
        foreground = "#000000";
        background = "#884900";
      };
      end = {
        foreground = "#000000";
        background = "#f2f2f2";
      };
    };

    selection = {
      text = "#000000";
      background = "#f2f2f2";
    };

    normal = {
      black = "#ffffff";
      red = "#a60000";
      green = "#006800";
      yellow = "#695500";
      blue = "#0031a9";
      magenta = "#721045";
      cyan = "#005e8b";
      white = "#000000";
    };

    bright = {
      black = "#f2f2f2";
      red = "#d00000";
      green = "#008900";
      yellow = "#808000";
      blue = "#0000ff";
      magenta = "#dd22dd";
      cyan = "#008899";
      white = "#595959";
    };

    dim = {
      black = "#f8f8f8";
      red = "#8f0000";
      green = "#005700";
      yellow = "#5d4700";
      blue = "#002891";
      magenta = "#5f0d3b";
      cyan = "#004f76";
      white = "#282828";
    };

    indexed_colors = [
      {
        index = 16;
        color = "#973300";
      }
      {
        index = 17;
        color = "#7f0000";
      }
    ];
  };

  darkColors = {
    primary = {
      background = "#000000";
      foreground = "#ffffff";
    };

    normal = {
      black = "#000000";
      red = "#ff5f59";
      green = "#44bc44";
      yellow = "#cabf00";
      blue = "#2fafff";
      magenta = "#feacd0";
      cyan = "#00d3d0";
      white = "#ffffff";
    };

    bright = {
      black = "#1e1e1e";
      red = "#ff5f5f";
      green = "#44df44";
      yellow = "#efef00";
      blue = "#338fff";
      magenta = "#ff66ff";
      cyan = "#00eff0";
      white = "#989898";
    };

    indexed_colors = [
      {
        index = 16;
        color = "#ffa00f";
      }
      {
        index = 17;
        color = "#ff9580";
      }
    ];
  };
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

        colors = if osConfig.theme.theme == "default-dark" then darkColors else lightColors;

        terminal.shell.program = "/etc/profiles/per-user/json/bin/zsh";

        window.padding = {
          x = 8;
          y = 0;
        };

        window.decorations_theme_variant = if osConfig.theme.theme == "default-dark" then "Dark" else "Light";
      };
    };
  };
}
