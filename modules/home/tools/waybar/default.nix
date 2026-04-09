{
  lib,
  config,
  ...
}:
let
  cfg = config.tools.waybar;
in
{
  options.tools.waybar.enable = lib.mkEnableOption "Enable Waybar";

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;

      settings.mainBar = {
        layer = "top";
        position = "top";
        height = 36;

        modules-left = [
          "niri/workspaces"
        ];
        modules-right = [
          "tray"
          "clock"
        ];

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "●";
            default = "○";
          };
        };

        clock = {
          format = "{:%a %b %d  %H:%M}";
          tooltip-format = "<tt>{calendar}</tt>";
        };

        tray = {
          spacing = 8;
        };
      };

      style = ''
        * {
          font-family: "Inter", "Iosevka Nerd Font";
          font-size: 14px;
          min-height: 0;
        }

        window#waybar {
          background: #000000;
          color: #f2f4f8;
        }

        #workspaces button {
          padding: 0 8px;
          color: #525252;
          border: none;
          border-radius: 0;
        }

        #workspaces button.active {
          color: #33b1ff;
        }

        #clock {
          padding: 0 12px;
          color: #f2f4f8;
          font-weight: 500;
        }

        #tray {
          padding: 0 8px;
        }

        #tray > .passive {
          -gtk-icon-effect: dim;
        }

        #tray > .needs-attention {
          -gtk-icon-effect: highlight;
        }

        tooltip {
          background: #161616;
          border: 1px solid #525252;
          border-radius: 4px;
        }

        tooltip label {
          color: #f2f4f8;
        }
      '';
    };
  };
}
