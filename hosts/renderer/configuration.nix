# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, inputs, outputs, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [
      inputs.alacritty-theme.overlays.default
      inputs.niri.overlays.niri
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      cudaSupport = true;
      chromium.commandLineArgs =
        "--enable-features=UseOzonePlatform --ozone-platform=wayland";
    };
  };

  nix = {
    #nixPath = [ "nixos-config=/home/json/configuration/nixos/configuration.nix" ];
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
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

  # Enable Niri Wayland compositor
  services.displayManager.sddm = {
    enable = true;
    wayland = { enable = true; };
    autoLogin = {
      enable = true;
      user = "json";
    };
  };
  services.displayManager.defaultSession = "niri";
  services.desktopManager.plasma6.enable = false;
  services.udisks2.enable = true;

  programs.niri = {
    enable = true;
    package = pkgs.niri;
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.json = {
    isNormalUser = true;
    description = "jsonnull";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "docker" ];
    #packages = with pkgs; [
    #];
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

  programs.adb.enable = true;
  programs.alvr = {
    enable = true;
    package = pkgs.alvr-passthrough;
    openFirewall = true;
  };

  services.tailscale.enable = true;

  virtualisation.docker.enable = true;

  systemd.services.strongdm = {
    enable = true;
    description = "idk";
    unitConfig = {
      ConditionFileIsExecutable = "${pkgs.sdm}/bin/sdm";
      Requires = "default.target";
      After = "default.target";
    };
    serviceConfig = {
      ExecStart = ''${pkgs.sdm}/bin/sdm "listen"'';
      Restart = "always";
      RestartSec = "3";
      User = "json";
      WorkingDirectory = "/home/json/.sdm";
      AmbientCapabilities = "CAP_NET_ADMIN";
    };
    wantedBy = [ "default.target" ];
    environment = { SDM_HOME = "/home/json/.sdm"; };
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    sdm
    unstable.slack
    cudatoolkit
    ungoogled-chromium
    xwayland-satellite
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

  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  hardware.bluetooth.enable = true;

  services.hardware.openrgb.enable = true;

  fonts.packages = with pkgs; [
    inter
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
  ];

  # Make the system work with nvidia card
  environment.sessionVariables.CUDA_PATH = "${pkgs.cudatoolkit}";
  environment.sessionVariables.LD_LIBRARY_PATH =
    "${pkgs.linuxPackages.nvidia_x11}/lib";
  #environment.sessionVariables.LD_LIBRARY_PATH = "${pkgs.cudatoolkit}/lib";
  environment.sessionVariables.VK_DRIVER_FILES =
    "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
  environment.sessionVariables.PROTON_ENABLE_NVAPI = "1";
  environment.sessionVariables.DXVK_ENABLE_NVAPI = "1";
  hardware.graphics = {
    enable = true;
    # For 32 bit applications
    enable32Bit = true;
    # extraPackages = with pkgs; [ rocm-opencl-icd rocm-opencl-runtime ];
  };
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    # Modesetting is required
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Do not disable this unless your GPU is unsupported or if you have a good reason to.
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
  boot.initrd.kernelModules = [ "nvidia" ];
  boot.kernelPackages = pkgs.linuxPackages_6_13;
  # fix for nVidia wayland plasma 6
  boot.kernelParams = [ "nvidia-drm.fbdev=1" "nvidia-drm.modeset=1" ];
  boot.blacklistedKernelModules = [ "nouveau" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
