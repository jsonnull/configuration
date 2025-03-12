{ pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Workaround for issue:
  # https://github.com/nix-community/home-manager/issues/3342
  manual.manpages.enable = false;

  home.packages = [
    pkgs.aider-chat
    pkgs.claude-code
    pkgs.ripgrep
    pkgs.nodejs_20
    pkgs.nodePackages.pm2
    pkgs.nodePackages.typescript-language-server
    pkgs.nodePackages.vscode-json-languageserver
    pkgs.nodePackages.yaml-language-server
    pkgs.gh
    pkgs.graphite-cli
    pkgs.rust-analyzer
    pkgs.nixd
    pkgs.nixpkgs-fmt
    pkgs.smug
    pkgs.wget
  ];

  home.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
    EDITOR = "nvim";
    TMUX_OVERRIDE_TERM = "false";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    history.size = 1000000;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "z" "vi-mode" ];
    };
    shellAliases = {
      gs = "git status -sb";
      vim = "nvim";
      yarn = "corepack yarn";
      yarnpkg = "corepack yarnpkg";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      nix_shell.format = "via [$symbol$name](bold blue)";
      nix_shell.symbol = " ";
      nodejs.symbol = " ";
      git_branch.symbol = " ";
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Jason Nall";
    userEmail = "json${"null"}${"@"}${"g"}${"ma"}${"il"}${"."}${"com"}";
    extraConfig = {
      push.default = "current";
      init.defaultBranch = "main";
    };
    ignores = [ ".direnv" ];
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    prefix = "C-a";
    # https://github.com/nix-community/home-manager/issues/5952
    sensibleOnTop = false;
    shell = "${pkgs.zsh}/bin/zsh";
    extraConfig = ''
      set -g default-terminal 'xterm-256color'
      set -as terminal-overrides ',xterm*:Tc:sitm=\E[3m'
    '';
    # TODO: Consolidate; I'm pretty sure this does the same thing as `set g default-terminal` above.
    terminal = "xterm-256color";
    plugins = [ pkgs.tmux-ayu-theme ];
  };
}
