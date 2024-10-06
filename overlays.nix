{ inputs }:
{
  additions = final: prev: import ./pkgs { pkgs = final; inherit inputs; };

  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    #   ...
    # });
  };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable
      {
        system = final.system;
        config.allowUnfree = true;
      };
  };
}
