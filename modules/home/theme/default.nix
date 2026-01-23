{ lib, ... }:
{
  options.homeTheme = {
    theme = lib.mkOption {
      type = lib.types.enum [ "default-light" "default-dark" ];
      default = "default-dark";
      description = "The theme to use (dark or light)";
    };
  };
}
