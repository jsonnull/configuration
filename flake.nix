{
  description = "We got here through trial and error";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixvim.url = "github:nix-community/nixvim/nixos-24.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , home-manager
    , nixvim
    , ...
    }:
    let
      inherit (self) outputs;
    in
    {
      overlays = import ./overlays.nix { inherit inputs; };

      # hosts
      nixosConfigurations.renderer = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/renderer/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = "backup";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [
              nixvim.homeManagerModules.nixvim
            ];
            home-manager.users.json = import ./hosts/renderer/home.nix;
          }
        ];
      };

      homeConfigurations.macbook = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./hosts/macbook/home.nix
          nixvim.homeManagerModules.nixvim
          {
            nixpkgs.overlays = [
              outputs.overlays.additions
              outputs.overlays.modifications
              outputs.overlays.unstable-packages
            ];
          }
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };

      homeConfigurations.wsl = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./hosts/wsl/home.nix
          nixvim.homeManagerModules.nixvim
          {
            nixpkgs.overlays = [
              outputs.overlays.additions
              outputs.overlays.modifications
              outputs.overlays.unstable-packages
            ];
          }
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
