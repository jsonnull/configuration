{
  config,
  pkgs,
  lib,
  ...
}:

let
  username = "jsonnull";
  homeDir = "/Users/jsonnull";
in
{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = username;
  home.homeDirectory = homeDir;

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

  # Enable app modules
  #apps.chrome.enable = true;
  #apps.discord.enable = true;
  #apps.slack.enable = true;

  # Enable tool modules
  #tools.alacritty.enable = true;
  tools.nixvim.enable = true;
  tools.obsidian.enable = true;
  tools.vscode.enable = true;
  #xdg.configFile.alacritty.source = lib.mkForce (../../config/alacritty-macbook);

  programs.zsh.initExtraFirst = ''
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
  '';
}
