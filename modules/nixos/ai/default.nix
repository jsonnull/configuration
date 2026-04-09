{
  pkgs,
  inputs,
  ...
}:
let
  llm-agents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  networking.firewall.allowedTCPPorts = [
    # sillytavern
    8000
    # delailah
    3000
    5173
  ];

  environment.systemPackages = [
    pkgs.sillytavern
    # pkgs.stable-diffusion-webui.forge.cuda # disabled: sphinx 9.1 incompatible with python 3.11
    llm-agents.claude-code
    llm-agents.qwen-code
  ];
}
