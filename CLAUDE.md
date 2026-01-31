# Configuration Repository

NixOS configuration using Nix flakes.

## Structure

- `hosts/` - Systems managed
  - `macbook/` - macOS home
  - `renderer/` - main NixOS system and home
- `modules/`
  - `nixos/` - NixOS modules
  - `home/` - Home Manager modules
- `packages/` - Custom packages
- `shells/` - Development shells

## Private Configuration

Additional configuration is kept in `../private-config/` for private settings.
