{
  lib,
  inputs,
  pkgs,
  mkShell,
  ...
}:
mkShell {
  packages = with pkgs; [
    age
    git
    sops
  ];
}
