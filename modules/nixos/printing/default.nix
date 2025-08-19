{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.printing;
in
{
  options.printing = {
    enable = mkEnableOption "enable printing configuration";
  };

  config = mkIf cfg.enable {
    # Theme configuration will be implemented here

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    services.printing.drivers = [
      pkgs.epson-escpr2
    ];
  };
}
