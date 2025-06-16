{
  pkgs,
  config,
  ...
}:
{
  # Enable Niri Wayland compositor
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
    autoLogin = {
      enable = true;
      user = "json";
    };
  };
  services.displayManager.defaultSession = "niri";
  services.udisks2.enable = true;

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
}
