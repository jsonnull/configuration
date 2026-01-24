{
  description = "We got here through trial and error";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stable-diffusion-webui-nix = {
      url = "github:Janrupf/stable-diffusion-webui-nix/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    "monochrome-vscode-theme" = {
      url = "github:jsonnull/github-vscode-theme-monochrome/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      allowedUnfree = [
        "1password"
        "1password-cli"
        "blender"
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
        "cudnn"
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

      overlays = [
        inputs.niri.overlays.niri
        inputs.stable-diffusion-webui-nix.overlays.default
      ];

      nixpkgsConfig = {
        allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) allowedUnfree;
      };
    in
    {
      nixosConfigurations.renderer = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # External modules
          inputs.sops-nix.nixosModules.sops
          inputs.home-manager.nixosModules.home-manager
          inputs.niri.nixosModules.niri

          # Custom NixOS modules (explicit)
          ./modules/nixos/theme
          ./modules/nixos/printing
          ./modules/nixos/ai
          ./modules/nixos/vr

          # Host configuration
          ./hosts/renderer/nixos

          # Home-manager integration
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.json = import ./hosts/renderer/home;
            };
          }

          # Nixpkgs config
          {
            nixpkgs = {
              inherit overlays;
              config = nixpkgsConfig;
            };
          }
        ];
      };

      homeConfigurations."jsonnull@macbook" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          inherit overlays;
          config = nixpkgsConfig;
        };
        extraSpecialArgs = { inherit inputs; };
        modules = [
          inputs.sops-nix.homeManagerModules.sops
          ./hosts/macbook/home
        ];
      };

      devShells =
        let
          forAllSystems = nixpkgs.lib.genAttrs [
            "x86_64-linux"
            "aarch64-darwin"
          ];
        in
        forAllSystems (system: {
          default =
            let
              pkgs = import nixpkgs {
                inherit system overlays;
                config = nixpkgsConfig;
              };
            in
            pkgs.mkShell {
              name = "configuration";
              packages = with pkgs; [
                nil
                nixfmt-rfc-style
              ];
            };
        });
    };
}
