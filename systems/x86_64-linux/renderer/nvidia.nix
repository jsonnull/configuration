{
  pkgs,
  config,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    cudatoolkit
  ];

  # Make the system work with nvidia card
  environment.sessionVariables.CUDA_PATH = "${pkgs.cudatoolkit}";
  #environment.sessionVariables.LD_LIBRARY_PATH = "${pkgs.linuxPackages.nvidia_x11}/lib";
  #environment.sessionVariables.LD_LIBRARY_PATH = "${pkgs.cudatoolkit}/lib";
  environment.sessionVariables.VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
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
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };
  boot.initrd.kernelModules = [ "nvidia" ];
  boot.kernelPackages = pkgs.linuxPackages_6_15;
  # fix for nVidia wayland plasma 6
  boot.kernelParams = [
    "nvidia-drm.fbdev=1"
    "nvidia-drm.modeset=1"
  ];
  boot.blacklistedKernelModules = [ "nouveau" ];
}
