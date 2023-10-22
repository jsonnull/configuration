# dotfiles

## Prerequisites

 - Install nix
    - [OS X](https://nixos.org/download.html)
    - [WSL](https://github.com/nix-community/NixOS-WSL)
 - [Install home-manager](https://nix-community.github.io/home-manager/index.html#ch-installation)
 - [Install packer](https://github.com/wbthomason/packer.nvim#quickstart)
 - [Install Iosevka (patched)](https://www.nerdfonts.com/font-downloads)

## Install

1. Clone the repo to `~/configuration`:
   
   ```sh
   git clone --recurse-submodules git@github.com:jsonnull/configuration.git ~/configuration
   ```

2. Depending on which system is being managed, install the configuration.
   
   WSL:
  
   ```sh
   nix run ~/configuration/home-manager#homeConfigurations.wsl.activationPackage
   ```

   MacBook:
   
   ```sh
   nix run ~/configuration/home-manager#homeConfigurations.macbook.activationPackage
   ```

3. Install neovim plugins:
   
   ```sh
   vim +PackerSync
   ```

4. When making updates to configs, switch to the new system.
   
   WSL:
  
   ```sh
   home-manager switch --impure --flake ~/configuration/home-manager#wsl
   ```
   
   MacBook:
   
   ```sh
   home-manager switch --impure --flake ~/configuration/home-manager#macbook
   ```

