{
  ...
}:
{
  programs.adb.enable = true;
  programs.alvr = {
    enable = true;
    #package = pkgs.alvr-passthrough;
    openFirewall = true;
  };
}
