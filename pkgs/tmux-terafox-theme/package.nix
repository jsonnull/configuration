{
  lib,
  stdenv,
  fetchFromGitHub,
  pkgs,
}:
pkgs.tmuxPlugins.mkTmuxPlugin {
  pluginName = "tmux-terafox-theme";
  version = "unstable-2025-04-09";
  src = fetchFromGitHub {
    owner = "EdenEast";
    repo = "nightfox.nvim";
    rev = "ba47d4b4c5ec308718641ba7402c143836f35aa9";
    hash = "sha256-HoZEwncrUnypWxyB+XR0UQDv+tNu1/NbvimxYGb7qu8=";
  };
  rtpFilePath = "extra/terafox/terafox.tmux";
}
