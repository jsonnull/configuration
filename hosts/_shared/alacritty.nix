{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      env.TERM = "xterm-256color";

      font.size = 12;
      font.offset = {
        x = 0;
        y = 2;
      };
      font.normal = {
        family = "IosevkaTerm Nerd Font";
        style = "Regular";
      };

      import = [ pkgs.alacritty-theme.kanagawa_wave ];

      shell.program = "/etc/profiles/per-user/json/bin/zsh";

      window.padding = {
        x = 10;
        y = 10;
      };
    };
  };
}
