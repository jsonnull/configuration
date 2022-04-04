{ config, pkgs, ... }:

let
  username = "jsonnull";
  homeDir = "/home/jsonnull";
in
{
  imports = [ ./common.nix ];

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = username;
  home.homeDirectory = homeDir;

  programs.zsh.initExtraFirst = ''
    . /home/jsonnull/.nix-profile/etc/profile.d/nix.sh

    autoload -Uz vcs_info # enable vcs_info
    precmd () { vcs_info } # always load before displaying the prompt

    zstyle ':vcs_info:*' formats '%F{green}%b%f' # (main)

    PROMPT='jsonnull@local %F{blue}%2/%f $vcs_info_msg_0_ $ ' # jsonnull@local /tmp/repo (main) $
  '';
}
