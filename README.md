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

2. Depending on which system is being managed, symlink the correct home-manager configuration:

   WSL:
  
   ```sh
   ln -s ~/configuration/home-manager/jsonnull-wsl.nix ~/.config/nixpkgs/home.nix
   ```

   MacBook:
  
   ```sh
   ln -s ~/configuration/macbook/jsonnull-macbook.nix ~/.config/nixpkgs/home.nix
   ```

3. Apply the configuration:
   
   ```sh
   home-manager switch
   ```

3. Install neovim plugins:
   
   ```sh
   vim +PackerSync
   ```
