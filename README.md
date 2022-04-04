# dotfiles

## Installation

1. Clone the repo to `~/configuration`:
  
  ```sh
  git clone git@github.com:jsonnull/configuration.git ~/configuration
  ```

2. Depending on which system is being managed, symlink the correct home-manager configuration:
  
  ```sh
  ln -s ~/configuration/home-manager/jsonnull-[system].nix ~/.config/nixpkgs/home.nix
  ```
