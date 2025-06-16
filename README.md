# dotfiles

## Prerequisites (non-NixOS)

- Install nix
  - [OS X](https://nixos.org/download)
  - [WSL](https://github.com/nix-community/NixOS-WSL)
    - See additional pre-installition steps below
- [Install home-manager](https://nix-community.github.io/home-manager/index.html#ch-installation)
- [Install packer](https://github.com/wbthomason/packer.nvim#quickstart)
- [Install Iosevka (patched)](https://www.nerdfonts.com/font-downloads)

### Additional pre-installation steps for WSL:

1. Run update as root to allow nixos-rebuild to work:

   ```sh
   sudo nix-channel --update
   ```

2. Update configuration in `/etc/nixos/configuration.nix`:

   ```nix
   wsl.defaultUser = "jsonnull";

   nix.extraOptions = ''
     experimental-features = nix-command flakes
   '';
   ```

## Install

1. Clone the repo to `~/configuration`:

   ```sh
   git clone --recurse-submodules git@github.com:jsonnull/configuration.git ~/configuration
   ```

2. Depending on which system is being managed, install the configuration.

   NixOS:

   ```sh
   sudo mv /etc/nixos /etc/nixos.bak
   sudo nixos-rebuild switch --flake .#renderer --impure --show-trace
   ```

   WSL:

   ```sh
   nix run --impure ~/configuration/#homeConfigurations.wsl.activationPackage

   # Afterwards, update /etc/nixos/configuration.nix:
   # users.defaultUserShell = "/home/jsonnull/.nix-profile/bin/zsh";
   ```

   MacBook:

   ```sh
   nix run --impure ~/configuration/#homeConfigurations.macbook.activationPackage
   ```

3. When making updates to configs, switch to the new system.

   WSL:

   ```sh
   home-manager switch --impure --flake ~/configuration#wsl
   ```

   MacBook:

   ```sh
   home-manager switch --impure --flake ~/configuration#macbook
   ```
