{
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    # External modules
    inputs.sops-nix.homeManagerModules.sops

    # Home modules (explicit)
    ../../../modules/home/theme
    ../../../modules/home/apps/slack
    ../../../modules/home/apps/chrome
    ../../../modules/home/apps/discord
    ../../../modules/home/tools/vscode
    ../../../modules/home/tools/ghostty
    ../../../modules/home/tools/nixcats
    ../../../modules/home/tools/obsidian
    ../../../modules/home/tools/zed
    ../../../modules/home/tools/gamedev
    ../../../modules/home/tools/_development
    ../../../modules/home/term
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.activation.expireGenerations = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.home-manager}/bin/home-manager expire-generations -5days
  '';

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Workaround for issue:
  # https://github.com/nix-community/home-manager/issues/3342
  manual.manpages.enable = false;

  home.packages = with pkgs; [
    prismlauncher
    kdePackages.kasts
    novelwriter
    photoqt
    r2modman
    sidequest
    kubernetes
    k9s
    gamescope
    jmtpfs
    android-file-transfer
    localsend
    mullvad-browser
    tor-browser
  ];

  home.file.".ssh/allowed_signers".text = "* ${builtins.readFile /home/json/.ssh/id_ed25519.pub}";

  #sops.defaultSopsFile = ../../../secrets.yaml;
  #sops.age.keyFile = "/home/${config.home.username}/.config/sops/age/keys.txt";
  #sops.secrets.jira-access-token = { };

  #home.sessionVariables.JIRA_API_TOKEN = builtins.readFile config.sops.secrets.jira-access-token.path;

  # Enable app modules
  apps.chrome.enable = true;
  apps.discord.enable = true;
  apps.slack.enable = true;

  # Enable tool modules
  tools.dev-general.enable = true;
  tools.ghostty.enable = true;
  tools.nixcats.enable = true;
  tools.obsidian.enable = true;
  tools.vscode.enable = true;
  tools.zed.enable = true;
  tools.gamedev.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "Jason Nall";
      user.email = "json${"null"}${"@"}${"g"}${"ma"}${"il"}${"."}${"com"}";
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };

  programs.obs-studio.enable = true;
}
