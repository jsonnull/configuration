{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.tools.vscode;
in
{
  options.tools.vscode.enable = lib.mkEnableOption "Enable VSCode";

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      profiles.default = {
        extensions =
          (with pkgs.vscode-extensions; [
            vscodevim.vim
            github.copilot
            github.vscode-pull-request-github
            github.github-vscode-theme
            #astro-build.astro-vscode
            jnoortheen.nix-ide
            dbaeumer.vscode-eslint
            esbenp.prettier-vscode
            bradlc.vscode-tailwindcss
            ms-vsliveshare.vsliveshare
          ])
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "claude-code";
              publisher = "anthropic";
              version = "1.0.61";
              sha256 = "sha256-is+JPO/qb2OxtCebtKadQPLUHZop+Xzch00RY72F7J0=";
            }
            {
              name = "svelte-vscode";
              publisher = "svelte";
              version = "109.1.0";
              sha256 = "sha256-ozD9k/zfklwBJtc1WdC52hgJckxBgVRmcZOwSYboACM=";
            }
          ];
        userSettings = {
          "editor.unicodeHighlight.nonBasicASCII" = false;
          "editor.largeFileOptimizations" = false;
          "editor.formatOnSave" = true;
          "editor.fontFamily" = "'IosevkaTerm Nerd Font', 'Droid Sans Mono', 'monospace', monospace";
          "terminal.integrated.fontFamily" =
            "'IosevkaTerm Nerd Font', 'Droid Sans Mono', 'monospace', monospace";
          "terminal.integrated.customGlyphs" = true;
          "editor.fontSize" = 14;
          "workbench.colorTheme" = "GitHub Dark Colorblind (Beta)";
          "workbench.tree.renderIndentGuides" = "none";
          "vim.textwidth" = 100;
          "vim.useSystemClipboard" = true;
          "vim.leader" = ",";
          "telemetry.telemetryLevel" = "off";
          "workbench.editor.tabSizing" = "fixed";
          "workbench.activityBar.location" = "top";
          "[typescriptreact]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "typescript.preferences.preferTypeOnlyAutoImports" = true;
          "[typescript]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "editor.minimap.enabled" = false;
          "github.copilot.enable" = {
            "*" = true;
          };
          "[jsonc]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[javascript]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "window.titleBarStyle" = "custom";
          "window.zoomLevel" = 1;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nil";
          "nix.serverSettinsg" = {
            "nil" = {
              "formatting" = {
                "command" = [ "nixfmt" ];
              };
            };
          };
          "extensions.autoUpdate" = false;
          "svelte.enable-ts-plugin" = true;
          # "[astro]" = {
          #     "editor.defaultFormatter" = "astro-build.astro-vscode"
          # }
        };
        keybindings = [
          {
            "key" = "ctrl+p";
            "command" = "-extension.vim_ctrl+p";
            "when" =
              "editorTextFocus && vim.active && vim.use<C-p> && !inDebugRepl || vim.active && vim.use<C-p> && !inDebugRepl && vim.mode == 'CommandlineInProgress' || vim.active && vim.use<C-p> && !inDebugRepl && vim.mode == 'SearchInProgressMode'";
          }
          {
            "key" = "ctrl+e";
            "command" = "-extension.vim_ctrl+e";
            "when" = "editorTextFocus && vim.active && vim.use<C-e> && !inDebugRepl";
          }
          {
            "key" = "ctrl+e";
            "command" = "-workbench.action.quickOpen";
          }
          {
            "key" = "ctrl+e";
            "command" = "workbench.action.findInFiles";
          }
          {
            "key" = "ctrl+shift+f";
            "command" = "-workbench.action.findInFiles";
          }
          {
            "key" = "ctrl+l";
            "command" = "-extension.vim_navigateCtrlL";
            "when" = "editorTextFocus && vim.active && vim.use<C-l> && !inDebugRepl";
          }
          {
            "key" = "ctrl+i";
            "command" = "-extension.vim_ctrl+i";
            "when" = "editorTextFocus && vim.active && vim.use<C-i> && !inDebugRepl";
          }
          {
            "key" = "ctrl+shift+e";
            "command" = "-workbench.view.explorer";
            "when" = "viewContainer.workbench.view.explorer.enabled";
          }
          {
            "key" = "ctrl+b";
            "command" = "-extension.vim_ctrl+b";
            "when" = "editorTextFocus && vim.active && vim.use<C-b> && !inDebugRepl && vim.mode != 'Insert'";
          }
          {
            "key" = "ctrl+t";
            "command" = "-extension.vim_ctrl+t";
            "when" = "editorTextFocus && vim.active && vim.use<C-t> && !inDebugRepl";
          }
        ];
      };
    };

  };
}
