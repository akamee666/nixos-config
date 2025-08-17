{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    font = "GohuFont 14 Nerd Font Mono";
    theme = ./rasi-files/theme.rasi;
  };
}
