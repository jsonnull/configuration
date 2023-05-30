# dotfiles

## Prerequisites

 - [Install nix](https://nixos.org/download.html)
 - [Install home-manager](https://nix-community.github.io/home-manager/index.html#ch-installation)
 - [Install packer](https://github.com/wbthomason/packer.nvim#quickstart)
 - [Install Iosevka (patched)](https://www.nerdfonts.com/font-downloads)

## Install

1. Clone the repo to `~/configuration`:
   
   ```sh
   git clone --recurse-submodules git@github.com:jsonnull/configuration.git ~/configuration
   ```

3. Copy the home-manager flake. Symlinking doesn't work here, and changes to this file need to be synced manually.
   
   ```sh
   cp ~/configuration/home-manager/flake.nix ~/.config/home-manager/flake.nix
   ```

4. Depending on which system is being managed, install the configuration.
   
   WSL:
  
   ```sh
   nix run ~/.config/home-manager#homeConfigurations.wsl.activationPackage
   ```

   MacBook:
   
   ```sh
   nix run ~/.config/home-manager#homeConfigurations.macbook.activationPackage
   ```

5. Install neovim plugins:
   
   ```sh
   vim +PackerSync
   ```

6. When making updates to configs, switch to the new system.
   
   WSL:
  
   ```sh
   home-manager switch --impure --flake ~/.config/home-manager#wsl
   ```
   
   MacBook:
   
   ```sh
   home-manager switch --impure --flake ~/.config/home-manager#macbook
   ```

