{
  # Snowfall Lib provides a customized `lib` instance with access to your flake's library
  # as well as the libraries available from your flake's inputs.
  lib,
  # An instance of `pkgs` with your overlays and packages applied is also available.
  pkgs,
  # You also have access to your flake's inputs.
  inputs,

  # Additional metadata is provided by Snowfall Lib.
  namespace, # The namespace used for your flake, defaulting to "internal" if not set.
  home, # The home architecture for this host (eg. `x86_64-linux`).
  target, # The Snowfall Lib target for this home (eg. `x86_64-home`).
  format, # A normalized name for the home target (eg. `home`).
  virtual, # A boolean to determine whether this home is a virtual target using nixos-generators.
  host, # The host name for this home.

  # All other arguments come from the home home.
  config,
  ...
}:
{
  # Home Manager needs a bit of information about you and the paths it should manage.
  #home.username = "json";
  #home.homeDirectory = "/home/json";

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

  home.packages = with pkgs; [
    prismlauncher
    kdePackages.kasts
    novelwriter
    photoqt
    r2modman
    sidequest
    kubernetes
    k9s
    gamescope
  ];

  home.file.".ssh/allowed_signers".text = "* ${builtins.readFile /home/json/.ssh/id_ed25519.pub}";

  # Enable app modules
  apps.chrome.enable = true;
  apps.discord.enable = true;
  apps.slack.enable = true;

  # Enable tool modules
  tools.alacritty.enable = true;
  tools.nixvim.enable = true;
  tools.obsidian.enable = true;
  tools.vscode.enable = true;

  # Enable Niri for desktop
  desktop.niri.enable = true;

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
}
