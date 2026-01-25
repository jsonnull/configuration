{
  lib,
  pkgs,
  config,
  ...
}:
{
  home.packages = [
    pkgs.repomix
    pkgs.ripgrep
    pkgs.nodejs_20
    pkgs.nodePackages.typescript-language-server
    pkgs.nodePackages.vscode-json-languageserver
    pkgs.nodePackages.yaml-language-server
    pkgs.gh
    pkgs.graphite-cli
    pkgs.rust-analyzer
    pkgs.nil
    pkgs.nixfmt-rfc-style
    pkgs.smug
    pkgs.wget
    pkgs._7zz
    pkgs.unzip
    pkgs.unar
  ];

  home.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
    EDITOR = "nvim";
    TMUX_OVERRIDE_TERM = "false";
  };

  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
      highlight = "fg=#006800"; # Using modus green for better visibility
    };
    syntaxHighlighting.enable = true;
    history.size = 1000000;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "z"
        "vi-mode"
      ];
    };
    shellAliases = {
      vim = "nvim";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      nix_shell.format = "via [$symbol$name](bold blue)";
      nix_shell.symbol = " ";
      nodejs.symbol = " ";
      git_branch.symbol = " ";
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    ignores = [
      ".direnv"
      ".claude/settings.local.json"
    ];
    settings = {
      user.name = "Jason Nall";
      user.email = "json${"null"}${"@"}${"g"}${"ma"}${"il"}${"."}${"com"}";
      push.default = "current";
      init.defaultBranch = "main";
    };
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    extraOptions = [
      "--group-directories-first"
    ];
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
    settings = {
      preview = {
        max_width = 4096;
        max_height = 4096;
      };
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    prefix = "C-a";
    # https://github.com/nix-community/home-manager/issues/5952
    sensibleOnTop = false;
    shell = "${pkgs.zsh}/bin/zsh";
    extraConfig = ''
      set -g status-style bg=white,fg=black

      set -g default-terminal 'xterm-256color'
      set -as terminal-overrides ',xterm*:Tc:sitm=\E[3m'

      #set -g status-left-length 100
      #set -g status-right-length 100
      set -g status-left "[#S] "
    '';
    # TODO: Consolidate; I'm pretty sure this does the same thing as `set g default-terminal` above.
    terminal = "xterm-256color";
  };
}
