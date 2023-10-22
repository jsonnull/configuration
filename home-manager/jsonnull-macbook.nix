{ config, pkgs, ... }:

let
  username = "jsonnull";
  homeDir = "/Users/jsonnull";
in
{
  imports = [
    ./common.nix
    ../private-configs/private-repos.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = username;
  home.homeDirectory = homeDir;

  programs.zsh.initExtraFirst = ''
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

    autoload -Uz vcs_info # enable vcs_info
    precmd () { vcs_info } # always load before displaying the prompt

    zstyle ':vcs_info:*' formats '%F{green}%b%f' # (main)

    PROMPT='jsonnull@local %F{blue}%2/%f $vcs_info_msg_0_ $ ' # jsonnull@local /tmp/repo (main) $
  '';
}
