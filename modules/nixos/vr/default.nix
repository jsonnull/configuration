{
  pkgs,
  ...
}:
{
  programs.adb.enable = true;

  services.monado = {
    enable = true;
    defaultRuntime = true;
  };

  services.wivrn = {
    enable = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    opencomposite
  ];

  snowfallorg.users.json.home.config = {
    xdg.configFile."openvr/openvrpaths.vrpath".text = ''
      {
        "version": 1,
        "runtime": [ "${pkgs.opencomposite}/bin/opencomposite" ]
      }
    '';
  };
}
