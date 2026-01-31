{
  pkgs,
  inputs,
  ...
}:
let
  pkgs-master = import inputs.nixpkgs-master {
    system = pkgs.system;
    config = pkgs.config;
  };
in
{
  programs.adb.enable = true;

  services.monado = {
    enable = true;
    defaultRuntime = true;
  };

  services.wivrn = {
    enable = true;
    openFirewall = true;
    package = pkgs-master.wivrn;
  };

  environment.systemPackages = with pkgs; [
    opencomposite
  ];

  home-manager.users.json = {
    xdg.configFile."openvr/openvrpaths.vrpath".text = ''
      {
        "version": 1,
        "runtime": [ "${pkgs.opencomposite}/bin/opencomposite" ]
      }
    '';
  };
}
