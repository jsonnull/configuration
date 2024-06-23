{
  description = "NixOS system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ...} @inputs:
    let 
      inherit (self) outputs;
    in
    {
      overlays = import ./overlays { inherit inputs; };

      # hosts
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem
        {
          specialArgs = {
            inherit inputs outputs;
          };
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.backupFileExtension = "backup";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.json = import ../home-manager/jsonnull-nixos.nix;
            }
          ];
        };
    };
}
