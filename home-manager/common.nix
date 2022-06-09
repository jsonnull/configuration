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
  home.stateVersion = "22.05";

  # Add overlay which provides neovim-nightly
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  home.packages = [
    pkgs.efm-langserver
    # https://github.com/nix-community/home-manager/issues/1907#issuecomment-887573079
    pkgs.neovim-nightly
    pkgs.ripgrep
    pkgs.nodejs-16_x
    pkgs.nodePackages.eslint_d
    pkgs.nodePackages.typescript-language-server
    pkgs.nodePackages.vscode-json-languageserver
    pkgs.nodePackages.vue-language-server
    pkgs.gh
    pkgs.rust-analyzer
  ];

  home.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
    EDITOR = "nvim";
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    history = {
      size = 1000000;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "z" "vi-mode" "tmux" ];
    };
    shellAliases = {
      gs = "git status -sb";
      vim = "nvim";
    };
  };

  programs.broot = {
    enable = true;
    modal = true;
    skin = {
      default = "none none";
    };
    verbs = [
      {
        invocation = "edit";
        key = "enter";
        external = "$EDITOR {file}";
        leave_broot = false;
        apply_to = "file";
      }
    ];
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
    terminal = "screen-256color";
  };

  xdg.configFile.nvim = {
    source = ~/configuration/config/nvim;
    recursive = true;
  };
}
