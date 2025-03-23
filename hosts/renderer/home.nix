{ pkgs, inputs, ... }:

let
  username = "json";
  homeDir = "/home/json";
in {
  imports = [
    ../_shared/home-common.nix
    ../_shared/nixvim.nix
    ../_shared/alacritty.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = username;
  home.homeDirectory = homeDir;

  home.packages = with pkgs; [
    discord
    unstable.prismlauncher
    kdePackages.kasts
    unstable.novelwriter
    obsidian
    photoqt
    r2modman
    sidequest
    kubernetes
    k9s
    swww
    waypaper
  ];

  home.file.".ssh/allowed_signers".text =
    "* ${builtins.readFile /home/json/.ssh/id_ed25519.pub}";

  programs.git = {
    enable = true;
    userName = "Jason Nall";
    userEmail = "json${"null"}${"@"}${"g"}${"ma"}${"il"}${"."}${"com"}";

    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        position = "top";
        modules-left = [ "niri/workspaces" "niri/window" ];
      };
    };
  };

  programs.fuzzel = { enable = true; };

  services.udiskie = {
    enable = true;
    settings = {
      program_options = {
        file_manager = "${pkgs.kdePackages.dolphin}/bin/dolphin";
      };
    };
  };

  programs.niri = {
    settings = {
      input.keyboard.xkb = {
        layout = "us";
        variant = "dvorak";
      };

      layout = { gaps = 30; };

      outputs = {
        "DP-5" = {
          mode = {
            width = 3440;
            height = 1440;
            refresh = 144.0;
          };
          position = {
            x = 1440;
            y = 699;
          };
        };
        "HDMI-A-2" = {
          mode = {
            width = 2560;
            height = 1440;
            refresh = 75.002;
          };
          transform = { rotation = 270; };
          position = {
            x = 0;
            y = 0;
          };
        };
      };

      spawn-at-startup = [
        # Maybe also start waybar
        { command = [ "xwayland-satellite" ":1" ]; }
        { command = [ "swww-daemon" ]; }
        { command = [ "waypaper --restore" ]; }
      ];

      environment = { DISPLAY = ":1"; };

      window-rules = [
        {
          matches = [{ app-id = "discord"; }];
          block-out-from = "screencast";
        }
        {
          matches = [{ app-id = "1Password"; }];
          block-out-from = "screencast";
        }
        {
          matches = [{ app-id = "steam"; }];
          block-out-from = "screencast";
        }
        {
          matches = [{ app-id = "org.kde.dolphin"; }];
          block-out-from = "screencast";
        }
        {
          matches = [{ app-id = "obsidian"; }];
          block-out-from = "screencast";
        }
        {
          matches = [{ app-id = "Alacritty"; }];
          opacity = 0.9;
          draw-border-with-background = false;
        }
        {
          matches = [{ app-id = "vrmonitor"; }];
          open-floating = false;
        }
      ];

      binds = {
        # Keys consist of modifiers separated by + signs, followed by an XKB key name
        # in the end. To find an XKB name for a particular key, you may use a program
        # like wev.
        #
        # "Mod" is a special modifier equal to Super when running on a TTY, and to Alt
        # when running as a winit window.
        #
        # Most actions that you can bind here can also be invoked programmatically with
        # `niri msg action do-something`.

        # Mod-Shift-/, which is usually the same as Mod-?,
        # shows a list of important hotkeys.
        "Mod+Shift+Slash".action.show-hotkey-overlay = { };

        # Suggested binds for running programs: terminal, app launcher, screen locker.
        "Mod+T".action.spawn = "alacritty";
        "Mod+D".action.spawn = "fuzzel";
        "Super+Alt+L".action.spawn = "swaylock";

        # You can also use a shell. Do this if you need pipes, multiple commands, etc.
        # Note: the entire command goes as a single argument in the end.
        # Mod+T { spawn "bash" "-c" "notify-send hello && exec alacritty"; }

        # Example volume keys mappings for PipeWire & WirePlumber.
        # The allow-when-locked=true property makes them work even when the session is locked.
        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" ];
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-" ];
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
        };
        "XF86AudioMicMute" = {
          allow-when-locked = true;
          action.spawn =
            [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
        };

        "Mod+Q".action.close-window = { };

        "Mod+Left".action.focus-column-left = { };
        "Mod+Down".action.focus-window-down = { };
        "Mod+Up".action.focus-window-up = { };
        "Mod+Right".action.focus-column-right = { };
        "Mod+H".action.focus-column-left = { };
        "Mod+J".action.focus-window-down = { };
        "Mod+K".action.focus-window-up = { };
        "Mod+L".action.focus-column-right = { };

        "Mod+Ctrl+Left".action.move-column-left = { };
        "Mod+Ctrl+Down".action.move-window-down = { };
        "Mod+Ctrl+Up".action.move-window-up = { };
        "Mod+Ctrl+Right".action.move-column-right = { };
        "Mod+Ctrl+H".action.move-column-left = { };
        "Mod+Ctrl+J".action.move-window-down = { };
        "Mod+Ctrl+K".action.move-window-up = { };
        "Mod+Ctrl+L".action.move-column-right = { };

        # Alternative commands that move across workspaces when reaching
        # the first or last window in a column.
        # Mod+J     { focus-window-or-workspace-down; }
        # Mod+K     { focus-window-or-workspace-up; }
        # Mod+Ctrl+J     { move-window-down-or-to-workspace-down; }
        # Mod+Ctrl+K     { move-window-up-or-to-workspace-up; }

        "Mod+Home".action.focus-column-first = { };
        "Mod+End".action.focus-column-last = { };
        "Mod+Ctrl+Home".action.move-column-to-first = { };
        "Mod+Ctrl+End".action.move-column-to-last = { };

        "Mod+Shift+Left".action.focus-monitor-left = { };
        "Mod+Shift+Down".action.focus-monitor-down = { };
        "Mod+Shift+Up".action.focus-monitor-up = { };
        "Mod+Shift+Right".action.focus-monitor-right = { };
        "Mod+Shift+H".action.focus-monitor-left = { };
        "Mod+Shift+J".action.focus-monitor-down = { };
        "Mod+Shift+K".action.focus-monitor-up = { };
        "Mod+Shift+L".action.focus-monitor-right = { };

        "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = { };
        "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = { };
        "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = { };
        "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = { };
        "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = { };
        "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = { };
        "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = { };
        "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = { };

        # Alternatively, there are commands to move just a single window:
        # Mod+Shift+Ctrl+Left  { move-window-to-monitor-left; }
        # ...

        # And you can also move a whole workspace to another monitor:
        # Mod+Shift+Ctrl+Left  { move-workspace-to-monitor-left; }
        # ...

        "Mod+Page_Down".action.focus-workspace-down = { };
        "Mod+Page_Up".action.focus-workspace-up = { };
        "Mod+U".action.focus-workspace-down = { };
        "Mod+I".action.focus-workspace-up = { };
        "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = { };
        "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = { };
        "Mod+Ctrl+U".action.move-column-to-workspace-down = { };
        "Mod+Ctrl+I".action.move-column-to-workspace-up = { };

        # Alternatively, there are commands to move just a single window:
        # Mod+Ctrl+Page_Down { move-window-to-workspace-down; }
        # ...

        "Mod+Shift+Page_Down".action.move-workspace-down = { };
        "Mod+Shift+Page_Up".action.move-workspace-up = { };
        "Mod+Shift+U".action.move-workspace-down = { };
        "Mod+Shift+I".action.move-workspace-up = { };

        # You can bind mouse wheel scroll ticks using the following syntax.
        # These binds will change direction based on the natural-scroll setting.
        #
        # To avoid scrolling through workspaces really fast, you can use
        # the cooldown-ms property. The bind will be rate-limited to this value.
        # You can set a cooldown on any bind, but it's most useful for the wheel.
        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action.focus-workspace-down = { };
        };
        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action.focus-workspace-up = { };
        };
        "Mod+Ctrl+WheelScrollDown" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-down = { };
        };
        "Mod+Ctrl+WheelScrollUp" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-up = { };
        };

        "Mod+WheelScrollRight".action.focus-column-right = { };
        "Mod+WheelScrollLeft".action.focus-column-left = { };
        "Mod+Ctrl+WheelScrollRight".action.move-column-right = { };
        "Mod+Ctrl+WheelScrollLeft".action.move-column-left = { };

        # Usually scrolling up and down with Shift in applications results in
        # horizontal scrolling; these binds replicate that.
        "Mod+Shift+WheelScrollDown".action.focus-column-right = { };
        "Mod+Shift+WheelScrollUp".action.focus-column-left = { };
        "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = { };
        "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = { };

        # Similarly, you can bind touchpad scroll "ticks".
        # Touchpad scrolling is continuous, so for these binds it is split into
        # discrete intervals.
        # These binds are also affected by touchpad's natural-scroll, so these
        # example binds are "inverted", since we have natural-scroll enabled for
        # touchpads by default.
        # Mod+TouchpadScrollDown { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+"; }
        # Mod+TouchpadScrollUp   { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-"; }

        # You can refer to workspaces by index. However, keep in mind that
        # niri is a dynamic workspace system, so these commands are kind of
        # "best effort". Trying to refer to a workspace index bigger than
        # the current workspace count will instead refer to the bottommost
        # (empty) workspace.
        #
        # For example, with 2 workspaces + 1 empty, indices 3, 4, 5 and so on
        # will all refer to the 3rd workspace.
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        "Mod+Ctrl+1".action.move-column-to-workspace = 1;
        "Mod+Ctrl+2".action.move-column-to-workspace = 2;
        "Mod+Ctrl+3".action.move-column-to-workspace = 3;
        "Mod+Ctrl+4".action.move-column-to-workspace = 4;
        "Mod+Ctrl+5".action.move-column-to-workspace = 5;
        "Mod+Ctrl+6".action.move-column-to-workspace = 6;
        "Mod+Ctrl+7".action.move-column-to-workspace = 7;
        "Mod+Ctrl+8".action.move-column-to-workspace = 8;
        "Mod+Ctrl+9".action.move-column-to-workspace = 9;

        # Alternatively, there are commands to move just a single window:
        # Mod+Ctrl+1 { move-window-to-workspace 1; }

        # Switches focus between the current and the previous workspace.
        # Mod+Tab { focus-workspace-previous; }

        "Mod+Comma".action.consume-window-into-column = { };
        "Mod+Period".action.expel-window-from-column = { };

        # There are also commands that consume or expel a single window to the side.
        # Mod+BracketLeft  { consume-or-expel-window-left; }
        # Mod+BracketRight { consume-or-expel-window-right; }

        "Mod+R".action.switch-preset-column-width = { };
        "Mod+Shift+R".action.reset-window-height = { };
        "Mod+F".action.maximize-column = { };
        "Mod+Shift+F".action.fullscreen-window = { };
        "Mod+C".action.center-column = { };

        # Finer width adjustments.
        # This command can also:
        # * set width in pixels: "1000"
        # * adjust width in pixels: "-5" or "+5"
        # * set width as a percentage of screen width: "25%"
        # * adjust width as a percentage of screen width: "-10%" or "+10%"
        # Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
        # set-column-width "100" will make the column occupy 200 physical screen pixels.
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";

        # Finer height adjustments when in column with other windows.
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        # Actions to switch layouts.
        # Note: if you uncomment these, make sure you do NOT have
        # a matching layout switch hotkey configured in xkb options above.
        # Having both at once on the same hotkey will break the switching,
        # since it will switch twice upon pressing the hotkey (once by xkb, once by niri).
        # Mod+Space       { switch-layout "next"; }
        # Mod+Shift+Space { switch-layout "prev"; }

        "Print".action.screenshot = { };
        "Ctrl+Print".action.screenshot-screen = { };
        "Alt+Print".action.screenshot-window = { };

        # The quit action will show a confirmation dialog to avoid accidental exits.
        "Mod+Shift+E".action.quit = { };

        # Powers off the monitors. To turn them back on, do any input like
        # moving the mouse or pressing any other key.
        "Mod+Shift+P".action.power-off-monitors = { };
      };
    };
  };

  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = [ pkgs.unstable.vscode-extensions.continue.continue ]
        ++ (with pkgs.vscode-extensions; [
          vscodevim.vim
          github.copilot
          github.vscode-pull-request-github
          #astro-build.astro-vscode
          jnoortheen.nix-ide
          dbaeumer.vscode-eslint
          esbenp.prettier-vscode
          bradlc.vscode-tailwindcss
          ms-vsliveshare.vsliveshare
        ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "Breeze";
            publisher = "kde";
            version = "0.0.4";
            sha256 = "sha256-3kFeBPBXhta8U9gollO6+anMmmE8OD3vDlVvsMbBtoU=";
          }
          {
            name = "noctis";
            publisher = "liviuschera";
            version = "10.43.3";
            sha256 = "sha256-RMYeW1J3VNiqYGj+2+WzC5X4Al9k5YWmwOyedFnOc1I=";
          }
          {
            name = "svelte-vscode";
            publisher = "svelte";
            version = "109.1.0";
            sha256 = "sha256-ozD9k/zfklwBJtc1WdC52hgJckxBgVRmcZOwSYboACM=";
          }
        ];
      userSettings = builtins.fromJSON ''
        {
              "editor.unicodeHighlight.nonBasicASCII": false,
              "editor.largeFileOptimizations": false,
              "editor.formatOnSave": true,
              "editor.fontFamily": "'IosevkaTerm Nerd Font', 'Droid Sans Mono', 'monospace', monospace",
              "editor.fontSize": 16,
              "workbench.colorTheme": "Noctis",
              "workbench.tree.renderIndentGuides": "none",
              "vim.textwidth": 100,
              "vim.useSystemClipboard": true,
              "vim.leader": ",",
              "telemetry.telemetryLevel": "off",
              "workbench.editor.tabSizing": "fixed",
              "workbench.activityBar.location": "top",
              "[typescriptreact]": {
                  "editor.defaultFormatter": "esbenp.prettier-vscode"
              },
              "typescript.preferences.preferTypeOnlyAutoImports": true,
              "[typescript]": {
                  "editor.defaultFormatter": "esbenp.prettier-vscode"
              },
              "editor.minimap.enabled": false,
              "github.copilot.editor.enableAutoCompletions": true,
              "[jsonc]": {
                  "editor.defaultFormatter": "esbenp.prettier-vscode"
              },
              "[javascript]": {
                  "editor.defaultFormatter": "esbenp.prettier-vscode"
              },
              "window.titleBarStyle": "custom",
              "nix.enableLanguageServer": true,
              "nix.serverPath": "nixd",
              "extensions.autoUpdate": false,
              "continue.enableContinueForTeamsBeta": true,
              "svelte.enable-ts-plugin": true
            }'';
      # "[astro]": {
      #     "editor.defaultFormatter": "astro-build.astro-vscode"
      # },
      keybindings = builtins.fromJSON ''
        [
              {
                  "key": "ctrl+p",
                  "command": "-extension.vim_ctrl+p",
                  "when": "editorTextFocus && vim.active && vim.use<C-p> && !inDebugRepl || vim.active && vim.use<C-p> && !inDebugRepl && vim.mode == 'CommandlineInProgress' || vim.active && vim.use<C-p> && !inDebugRepl && vim.mode == 'SearchInProgressMode'"
              },
              {
                  "key": "ctrl+e",
                  "command": "-extension.vim_ctrl+e",
                  "when": "editorTextFocus && vim.active && vim.use<C-e> && !inDebugRepl"
              },
              {
                  "key": "ctrl+e",
                  "command": "-workbench.action.quickOpen"
              },
              {
                  "key": "ctrl+e",
                  "command": "workbench.action.findInFiles"
              },
              {
                  "key": "ctrl+shift+f",
                  "command": "-workbench.action.findInFiles"
              },
              {
                  "key": "ctrl+l",
                  "command": "-extension.vim_navigateCtrlL",
                  "when": "editorTextFocus && vim.active && vim.use<C-l> && !inDebugRepl"
              },
              {
                  "key": "ctrl+i",
                  "command": "-extension.vim_ctrl+i",
                  "when": "editorTextFocus && vim.active && vim.use<C-i> && !inDebugRepl"
              },
              {
                  "key": "ctrl+shift+e",
                  "command": "-workbench.view.explorer",
                  "when": "viewContainer.workbench.view.explorer.enabled"
              },
              {
                  "key": "ctrl+b",
                  "command": "-extension.vim_ctrl+b",
                  "when": "editorTextFocus && vim.active && vim.use<C-b> && !inDebugRepl && vim.mode != 'Insert'"
              },
              {
                  "key": "ctrl+t",
                  "command": "-extension.vim_ctrl+t",
                  "when": "editorTextFocus && vim.active && vim.use<C-t> && !inDebugRepl"
              }
            ]'';
    };
  };
}
