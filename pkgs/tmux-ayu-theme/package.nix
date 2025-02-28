{ lib, stdenv, fetchFromGitHub, pkgs, }:
pkgs.tmuxPlugins.mkTmuxPlugin {
  pluginName = "tmux-ayu-theme";
  version = "unstable-2025-01-04";
  src = fetchFromGitHub {
    owner = "TechnicalDC";
    repo = "tmux-ayu-theme";
    rev = "2ddd8537e2f98cc760c1e2ded4bcbc62a20b8f42";
    hash = "sha256-/MLP0tE5wSQ/Vcnruy34bQ5kes6AoT0zH2urBcetiq0=";
  };
  rtpFilePath = "tmux-ayu-theme.tmux";
}
