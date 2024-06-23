{ config, pkgs, ... }:

let
  username = "jsonnull";
  homeDir = "/Users/jsonnull";
in
{
  imports = [
    ../_shared/home-common.nix
    ../../../private-configs/private-repos.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = username;
  home.homeDirectory = homeDir;

  programs.zsh.initExtraFirst = ''
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
  '';
}
