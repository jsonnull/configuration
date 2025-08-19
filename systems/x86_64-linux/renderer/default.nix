{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./niri.nix
    ./nvidia.nix
  ];

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 5d";
    };
    optimise.automatic = true;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-9f4a94c8-8b60-405b-bbe9-42c13c394de0".device =
    "/dev/disk/by-uuid/9f4a94c8-8b60-405b-bbe9-42c13c394de0";

  networking.hostName = "renderer"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [
    # localsend
    53317
  ];
  networking.firewall.allowedUDPPorts = [
    # localsend
    53317
  ];

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "dvorak";
  };

  # Configure console keymap
  console.keyMap = "dvorak";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.json = {
    isNormalUser = true;
    description = "jsonnull";
    extraGroups = [
      "networkmanager"
      "wheel"
      "adbusers"
      "docker"
    ];
  };

  # Enable home-manager for the user
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  # This enables the Snowfall home configuration for this user
  snowfallorg.users.json.home.enable = true;

  # Enable home printing
  printing.enable = true;

  # Enable theme configuration
  theme = {
    enable = true;
    theme = "default-dark";
  };

  programs.firefox.enable = true;
  programs._1password.enable = true;
  programs._1password-gui.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  services.tailscale.enable = true;

  virtualisation.docker.enable = true;

  /*
    systemd.services.strongdm = {
      enable = true;
      description = "idk";
      unitConfig = {
        ConditionFileIsExecutable = "${pkgs.strongdm}/bin/sdm";
        Requires = "default.target";
        After = "default.target";
      };
      serviceConfig = {
        ExecStart = ''${pkgs.strongdm}/bin/sdm "listen"'';
        Restart = "always";
        RestartSec = "3";
        User = "json";
        WorkingDirectory = "/home/json/.sdm";
        AmbientCapabilities = "CAP_NET_ADMIN";
      };
      wantedBy = [ "default.target" ];
      environment = {
        SDM_HOME = "/home/json/.sdm";
      };
    };
  */

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    #strongdm
    _7zz
    unar
    unzip

    # KDE applications to keep
    kdePackages.dolphin
    kdePackages.elisa

    nautilus
  ];

  # Virtualbox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  # Slack
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.GTK_USE_PORTAL = "1";
  #environment.sessionVariables.ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  #services.gnome3.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  hardware.bluetooth.enable = true;

  services.hardware.openrgb.enable = true;

  fonts.packages = with pkgs; [
    inter
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
