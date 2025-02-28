{ pkgs, inputs }: {
  alvr-passthrough = pkgs.callPackage ./alvr-passthrough/package.nix { };
  sdm = pkgs.callPackage ./sdm/package.nix { };
  klassyQt6 = pkgs.callPackage ./klassy/package.nix { qtMajorVersion = "6"; };
  tmux-ayu-theme = pkgs.callPackage ./tmux-ayu-theme/package.nix { };
}
