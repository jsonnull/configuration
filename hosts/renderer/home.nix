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
    r2modman
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

  programs.vscode = {
    enable = true;
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
    #{
    #    "key": "ctrl+l",
    #    "command": "workbench.view.explorer",
    #    "when": "viewContainer.workbench.view.explorer.enabled"
    #},
  };
}
