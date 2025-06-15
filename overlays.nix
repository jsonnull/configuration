{ inputs }: {
  additions = final: prev:
    import ./pkgs {
      pkgs = final;
      inherit inputs;
    };

  modifications = final: prev:
    {
      # example = prev.example.overrideAttrs (oldAttrs: rec {
      #   ...
      # });
    };
}
