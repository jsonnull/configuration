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

      homes.users."json@renderer".modules = with inputs; [ nixvim.homeManagerModules.nixvim ];

      homes.users."jsonnull@macbook".modules = with inputs; [ nixvim.homeManagerModules.nixvim ];
    };
}
