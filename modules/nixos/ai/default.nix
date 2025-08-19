{
  pkgs,
  ...
}:
{
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    loadModels = [
      "gemma3:12b"
      #"gpt-oss:20b"
    ];
  };

  environment.systemPackages = with pkgs; [
    alpaca
  ];
}
