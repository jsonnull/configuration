{
  pkgs,
  inputs,
  ...
}:
let
  pkgsMaster = import inputs.nixpkgs-master {
    system = pkgs.system;
    #config.allowUnfree = true;
  };
in
{
  services.ollama = {
    enable = true;
    loadModels = [
      #"gemma3:12b"
      #"gpt-oss:20b"
    ];
    openFirewall = true;
    host = "[::]";
    #package = pkgsMaster.ollama;
  };

  networking.firewall.allowedTCPPorts = [
    # sillytavern
    8000
  ];

  environment.systemPackages = [
    pkgsMaster.alpaca
    pkgs.sillytavern
    (pkgs.koboldcpp.override {
      config.cudaSupport = true;
      cudaArches = [ "sm_89" ];
    })
    pkgs.stable-diffusion-webui.forge.cuda
  ];
}
