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
    pkgs.r2modman
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
        name = "Breeze";
        publisher = "kde";
        version = "0.0.4";
        sha256 = "sha256-3kFeBPBXhta8U9gollO6+anMmmE8OD3vDlVvsMbBtoU=";
      }
      {
        name = "discord-vscode";
        publisher = "icrawl";
        version = "5.8.0";
        sha256 = "sha256-IU/looiu6tluAp8u6MeSNCd7B8SSMZ6CEZ64mMsTNmU=";
      }
    ];
    userSettings = builtins.fromJSON ''{
      "editor.unicodeHighlight.nonBasicASCII": false,
      "editor.largeFileOptimizations": false,
      "workbench.colorTheme": "Breeze",
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
      "discord.detailsDebugging": "Debugging",
      "discord.detailsEditing": "Coding",
      "discord.largeImage": "Editing a {lang} file",
      "discord.lowerDetailsDebugging": "Debugging",
      "discord.lowerDetailsEditing": "Coding",
      "discord.removeLowerDetails": true,
      "discord.removeRemoteRepository": true,
      "discord.removeTimestamp": true
    }'';
    keybindings = builtins.fromJSON ''[
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
          "key": "ctrl+l",
          "command": "workbench.view.explorer",
          "when": "viewContainer.workbench.view.explorer.enabled"
      },
      {
          "key": "ctrl+shift+e",
          "command": "-workbench.view.explorer",
          "when": "viewContainer.workbench.view.explorer.enabled"
      }
    ]'';
  };
}
