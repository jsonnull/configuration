{
  pkgs,
  inputs,
  ...
}:
let
  pkgsMaster = import inputs.nixpkgs-master { system = pkgs.system; };
in
{
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    loadModels = [
      #"gemma3:12b"
      #"gpt-oss:20b"
    ];
    openFirewall = true;
    host = "[::]";
  };

  networking.firewall.allowedTCPPorts = [
    # sillytavern
    8000
  ];

  environment.systemPackages = [
    pkgsMaster.alpaca
    pkgs.sillytavern
    #pkgs.stable-diffusion-webui.forge.cuda
  ];
}
