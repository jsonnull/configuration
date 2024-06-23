{ pkgs, inputs }: {
  klassyQt6 = pkgs.callPackage ./klassy/package.nix { qtMajorVersion = "6"; };
}
