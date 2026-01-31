{
  pkgs,
  inputs,
  ...
}:
let
  llm-agents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
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
  };

  networking.firewall.allowedTCPPorts = [
    # sillytavern
    8000
    # delailah
    3000
    5173
  ];

  environment.systemPackages = [
    pkgs.sillytavern
    pkgs.stable-diffusion-webui.forge.cuda
    llm-agents.claude-code
    llm-agents.qwen-code
  ];
}
