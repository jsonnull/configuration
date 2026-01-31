# configuration

## Prerequisites (macOS)

- [Install nix](https://nixos.org/download)
- [Install home-manager](https://nix-community.github.io/home-manager/index.html#ch-installation)
- [Install Iosevka Nerd Font](https://www.nerdfonts.com/font-downloads)

## Install

Clone the repo to `~/configuration`:

```sh
git clone git@github.com:jsonnull/configuration.git ~/configuration
```

NixOS:

```sh
sudo nixos-rebuild switch --flake .#renderer --impure
```

MacBook (home-manager only):

```sh
home-manager switch --flake ~/configuration#jsonnull@macbook --impure
```

> `--impure` is required because the config reads the SSH public key from an absolute path for git commit signing.
