{ pkgs, ... }:

let
  username = "json";
  homeDir = "/home/json";
in
{
  imports = [
    ../_shared/home-common.nix
    /home/json/configuration/private-configs/hosts/renderer.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = username;
  home.homeDirectory = homeDir;

  home.packages = [
    pkgs.tidal-hifi
    pkgs.discord
  ];

  programs.vscode = {
    enable = true;
    extensions = (with pkgs.vscode-extensions; [
      vscodevim.vim
      github.copilot
      astro-build.astro-vscode
      jnoortheen.nix-ide
      dbaeumer.vscode-eslint
      esbenp.prettier-vscode
      bradlc.vscode-tailwindcss
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "Noctis";
        publisher = "liviuschera";
        version = "10.43.3";
        sha256 = "sha256-RMYeW1J3VNiqYGj+2+WzC5X4Al9k5YWmwOyedFnOc1I=";
      }
    ];
    userSettings = builtins.fromJSON ''{
      "editor.unicodeHighlight.nonBasicASCII": false,
      "editor.largeFileOptimizations": false,
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
      "nix.serverPath": "nixd"
    }'';
  };
}
