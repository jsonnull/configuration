{ config, pkgs, ... }:

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
  home.stateVersion = "23.05";

  # Workaround for issue:
  # https://github.com/nix-community/home-manager/issues/3342
  manual.manpages.enable = false;

  # Add overlay which provides neovim-nightly
  /*
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];
  */

  home.packages = [
    # https://github.com/nix-community/home-manager/issues/1907#issuecomment-887573079
    # pkgs.neovim-nightly
    pkgs.neovim
    pkgs.ripgrep
    pkgs.nodejs-18_x
    pkgs.nodePackages.pm2
    pkgs.nodePackages.typescript-language-server
    pkgs.nodePackages.vscode-json-languageserver
    pkgs.nodePackages.yaml-language-server
    pkgs.gh
    pkgs.rust-analyzer
    pkgs.smug
  ];

  home.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
    EDITOR = "nvim";
    TMUX_OVERRIDE_TERM = "false";
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    history = {
      size = 1000000;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "z" "vi-mode" ];
    };
    shellAliases = {
      gs = "git status -sb";
      vim = "nvim";
      yarn = "corepack yarn";
      yarnpkg = "corepack yarnpkg";
      pnpm = "corepack pnpm";
      pnpx = "corepack pnpx";
      npm = "corepack npm";
      npx = "corepack npx";
    };
    #initExtra = ''
    #  export TERM="xterm-256color"
    #'';
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Jason Nall";
    userEmail = "jsonnull@gmail.com";
    extraConfig = { push.default = "current"; init.defaultBranch = "main"; };
    ignores = [ ".direnv" ];
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    prefix = "C-a";
    shell = "${pkgs.zsh}/bin/zsh";
    extraConfig = ''
      set -g default-terminal 'xterm-256color'
      set -as terminal-overrides ',xterm*:Tc:sitm=\E[3m'
    '';
    # TODO: Consolidate; I'm pretty sure this does the same thing as `set g default-terminal` above.
    terminal = "xterm-256color";
  };

  xdg.configFile.nvim = {
    source = ~/configuration/config/nvim;
    recursive = true;
  };

  # Give copilot in neovim a handle to node 16 (node 18 is not yet supported)
  # https://github.com/orgs/community/discussions/16800
  xdg.configFile."nvim/lua/nix.lua".text = ''
    vim.g.copilot_node_command = "${pkgs.nodejs-16_x}/bin/node"
  '';
}
