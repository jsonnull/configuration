{ config, lib, pkgs, ... }:

let
  username = "jsonnull";
  homeDir = "/home/jsonnull";
in
{
  imports = [
    ./common.nix
    ../private-configs/private-repos.nix
    "${fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master"}/modules/vscode-server/home.nix"
  ];

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = username;
  home.homeDirectory = homeDir;

  home.activation = {
    copyAlacrittyConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      APPDATA=$(/bin/wslpath "$(/mnt/c/Windows/system32/cmd.exe /c echo '%APPDATA%')" | tr -d '\r')
      $DRY_RUN_CMD mkdir -p "$APPDATA/alacritty/"
      $DRY_RUN_CMD cp -r ~/configuration/config/alacritty-windows/* "$APPDATA/alacritty/"
    '';
  };

  home.packages = [
    pkgs.cryptsetup
  ];

  services.vscode-server.enable = true;
}
