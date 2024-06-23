{ config, lib, pkgs, ... }:

let
  username = "json";
  homeDir = "/home/json";
in
{
  imports = [
    ../_shared/home-common.nix
    #../../../private-configs/private-repos.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = username;
  home.homeDirectory = homeDir;

  home.packages = [
    pkgs.tidal-hifi
    pkgs.discord
  ];

  programs.vscode.enable = true;
}
