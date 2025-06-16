{
  description = "We got here through trial and error";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;
        snowfall = {
          namespace = "jsonnull";
          meta = {
            name = "jsonnull";
            title = "jsonnull";
          };
        };
      };
    in
    lib.mkFlake {

      channels-config = {
        allowUnfreePredicate =
          pkg:
          builtins.elem (lib.getName pkg) [
            "1password"
            "1password-cli"
            "claude-code"
            "cuda-merged"
            "cuda_cccl"
            "cuda_cudart"
            "cuda_cuobjdump"
            "cuda_cupti"
            "cuda_cuxxfilt"
            "cuda_gdb"
            "cuda_nvcc"
            "cuda_nvdisasm"
            "cuda_nvml_dev"
            "cuda_nvprune"
            "cuda_nvrtc"
            "cuda_nvtx"
            "cuda_profiler_api"
            "cuda_sanitizer_api"
            "discord"
            "graphite-cli"
            "libcublas"
            "libcufft"
            "libcurand"
            "libcusolver"
            "libcusparse"
            "libnpp"
            "libnvjitlink"
            "nvidia-settings"
            "nvidia-x11"
            "obsidian"
            "slack"
            "steam"
            "steam-unwrapped"
            "vscode"
            "vscode-extension-github-copilot"
            "vscode-extension-ms-vsliveshare-vsliveshare"
          ];
      };

      overlays = [
        inputs.alacritty-theme.overlays.default
        inputs.niri.overlays.niri
      ];

      systems.hosts.renderer.modules = with inputs; [
	home-manager.nixosModules.home-manager
        niri.nixosModules.niri
      ];

      # Add modules to all homes.
      homes.modules = with inputs; [
        # my-input.homeModules.my-module
      ];

      homes.users."json@renderer".modules = with inputs; [
        nixvim.homeManagerModules.nixvim
        # self.homeModules.common
        # self.homeModules.nixvim
        # self.homeModules.alacritty
      ];
    };

  /*
    overlays = import ./overlays.nix { inherit inputs; };

      # hosts
      nixosConfigurations.renderer = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        system = "x86_64-linux";
        modules = [
          #./modules/sdm/default.nix
          ./hosts/renderer/configuration.nix
          home-manager.nixosModules.home-manager
          inputs.niri.nixosModules.niri
          {
            home-manager.backupFileExtension = "backup";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ nixvim.homeManagerModules.nixvim ];
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
            nixpkgs.overlays =
              [ outputs.overlays.additions outputs.overlays.modifications ];
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
            nixpkgs.overlays =
              [ outputs.overlays.additions outputs.overlays.modifications ];
          }
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
  */
}
